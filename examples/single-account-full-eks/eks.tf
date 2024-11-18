# SPDX-License-Identifier: Apache-2.0
#
# Copyright (C) 2023 The Falco Authors.
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#-------------------------------------
# VPC
#-------------------------------------
# You can use the following module to create a VPC with public and private subnets across multiple availability zones.
# If you want to use an existing VPC, you can skip this module and provide the VPC ID and subnet IDs as input to the K8s modules.

module "vpc" {
  source = "../../modules/infrastructure/vpc"
  name   = var.name
  tags   = var.tags
}

#-------------------------------------
# EKS
#-------------------------------------
# This module creates an EKS cluster with the specified number of nodes and instance type.

module "eks_cluster" {
  source  = "../../modules/infrastructure/eks"
  name    = var.name
  vpc_id  = module.vpc.vpc_id              # Change this value to the VPC ID if you are using an existing VPC
  subnets = module.vpc.private_subnets_ids # Change this value to your private list of subnets ids if you are using an existing VPC
  # cluster_endpoint_public_access_cidrs = ["YOUR_CIDR_BLOCKs"] # Set to the list of CIDR blocks that you want to allow access to the EKS cluster
  # cluster_endpoint_public_access = true # Set to false if you want to restrict the access to the EKS cluster
  node_count    = 2
  instance_type = "t2.xlarge"
  # By default, the EKS cluster will create an access entry for the user/role that is used to create the cluster.
  # acces_entries = [
  #   {
  #     principal_arn     = "YOUR_PRINCIPAL OR USERS ARN"
  #     policy_arn        = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  #     name              = "eks-admin"
  #     type              = "STANDARD"
  #     access_scope_type = "cluster"
  #   }
  # ]
  tags = var.tags
}

# Updating the default storage class to use in the EKS cluster
# Necesaary for the FalcoSidekick redis deployment to create the PVC
resource "kubernetes_storage_class" "gp3" {
  metadata {
    name = "gp3"
    annotations = {
      "storageclass.kubernetes.io/is-default-class" : "true" # Set the default storage class for the cluster
    }
  }
  storage_provisioner = "kubernetes.io/aws-ebs"
  reclaim_policy      = "Delete"
  parameters = {
    type = "gp3"
  }
  volume_binding_mode    = "WaitForFirstConsumer"
  allow_volume_expansion = true
}

# Falco Helm chart
resource "helm_release" "falco" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "falco"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
  version          = "4.14.1"
  namespace        = "falco"
  create_namespace = true
  wait             = false
  recreate_pods    = true
  timeout          = 600

  values = [
    templatefile("${path.module}/falco-config/falco-values.yaml", {
      aws_region    = var.aws_region
      sqs_name      = module.sqs_sns_subscription.name
      irsa_role_arn = module.irsa.iam_role_arn
    })
  ]
}

# Installation for the EKS audit log config
resource "helm_release" "k8saudit" {
  # Uncomment the following line to use the KOPS cluster provider
  # provider = helm.kops_cluster
  name             = "k8saudit"
  repository       = "https://falcosecurity.github.io/charts"
  chart            = "falco"
  version          = "4.14.1"
  namespace        = "falco"
  create_namespace = true
  wait             = false
  recreate_pods    = true
  timeout          = 600

  values = [
    templatefile("${path.module}/falco-config/falco-eks-audit-values.yaml", {
      aws_region    = var.aws_region
      irsa_role_arn = module.irsa.iam_role_arn
      cluster_name  = module.eks_cluster.cluster_name
    })
  ]

  depends_on = [helm_release.falco]
}

module "irsa" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~> 5.38"

  role_name = "irsa-${var.name}"
  role_policy_arns = {
    policy = aws_iam_policy.falco.arn
  }

  oidc_providers = {
    main = {
      provider_arn               = module.eks_cluster.oidc_provider_arn
      namespace_service_accounts = ["falco:falco"]
    }
  }

  tags = var.tags
}


resource "aws_iam_policy" "falco" {
  name = var.name
  path = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "S3Access",
        Action = [
          "s3:Get*",
          "s3:List*",
          "s3:Describe*",
          "s3-object-lambda:Get*",
          "s3-object-lambda:List*"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Sid = "SQSAccess",
        Action = [
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:GetQueueUrl",
          "sqs:DeleteMessage",
          "sqs:ListDeadLetterSourceQueues",
          "sqs:ListQueues",
          "sqs:ListMessageMoveTasks",
          "sqs:ListQueueTags"
        ]
        Effect   = "Allow"
        Resource = ["*"]
      },
      {
        Sid    = "ReadAccessToCloudWatchLogs",
        Effect = "Allow",
        Action = [
          "logs:Describe*",
          "logs:FilterLogEvents",
          "logs:Get*",
          "logs:List*"
        ],
        Resource = [
          "${module.eks_cluster.cloudwatch_log_group_arn}:*"
        ]
      }
    ]
  })
  tags = var.tags
}
