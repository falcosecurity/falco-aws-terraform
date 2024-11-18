locals {
  name            = var.name
  cluster_version = var.k8s_version
  instance_type   = var.instance_type
  # This is the list of extra entities access to the EKS cluster
  acces_entries = { for access in var.acces_entries :
    access["name"] => {
      principal_arn = access["principal_arn"]
      type          = access["type"]

      policy_associations = {
        admin = {
          policy_arn = access["policy_arn"]
          access_scope = {
            type = access["access_scope_type"]
          }
        }
      }
    }
  }

  tags = var.tags
}

################################################################################
# EKS Module
################################################################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~>20.0"

  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  # To add the IAM identity of the creator of the cluster to the Kubernetes RBAC configuration
  enable_cluster_creator_admin_permissions = true

  cluster_security_group_additional_rules = var.cluster_security_group_additional_rules

  access_entries = local.acces_entries

  cluster_endpoint_public_access_cidrs = var.cluster_endpoint_public_access_cidrs

  # EKS Addons
  cluster_addons = {
    coredns = {
      addon_version = var.aws-coredns-driver-version
    }
    kube-proxy = {
      addon_version = var.aws-kube-proxy-driver-version
    }
    aws-ebs-csi-driver = {
      addon_version = var.aws-ebs-csi-driver-version
    }
    vpc-cni = {
      # Specify the VPC CNI addon should be deployed before compute to ensure
      # the addon is configured before data plane compute resources are created
      # See README for further details
      resolve_conflicts_on_create = "OVERWRITE"
      resolve_conflicts_on_update = "OVERWRITE"
      before_compute              = true
      addon_version               = var.vpc-cni-version # Ref to https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html#vpc-cni-latest-available-version
      configuration_values = jsonencode({
        enableNetworkPolicy = "true" # Adding support for K8s Network Policies
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  eks_managed_node_groups = {
    default = {
      use_name_prefix = true
      name            = "eks-node"

      #create_launch_template = false
      #launch_template_name   = "template"

      min_size     = var.node_count
      max_size     = var.node_count
      desired_size = var.node_count

      metadata_options = {
        # INFO: Forcing to use IMDSv2 for the metadata service endpoint
        http_tokens                 = "required"
        http_endpoint               = "enabled"
        http_put_response_hop_limit = 2
      }

      instance_types = [local.instance_type]
      # Needed by the aws-ebs-csi-driver
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
      }

      iam_role_policy_statements = [
        # K8s worker nodes IAM policy example defitinition
        # {
        #   effect = "Allow"
        #   actions = [
        #     "s3:Get*",
        #     "s3:List*",
        #     "s3:Describe*",
        #     "s3-object-lambda:Get*",
        #     "s3-object-lambda:List*",
        #     "s3:PutBucketPolicy"
        #   ]
        #   resources = ["arn:aws:s3:::name"]
        # }
      ]
    }
  }

  enable_irsa = true

  cluster_identity_providers = var.eks_oidc_idp

  # Additional node security group rules to allow access from the control plane
  node_security_group_additional_rules = var.extra_node_security_groups_rules

  tags = local.tags
}
