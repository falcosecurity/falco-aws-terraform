variable "name" {
  description = "EKS cluster name"
  type        = string
}

variable "node_count" {
  type        = number
  default     = 1
  description = "The minimun number of nodes to run in the cluster"
}

variable "instance_type" {
  type        = string
  default     = "t2.medium"
  description = "The type of the instance nodes"
}

variable "acces_entries" {
  description = "Map of access entries to add to the cluster"
  type = list(object({
    principal_arn     = string
    policy_arn        = string
    name              = string
    type              = string
    access_scope_type = string
  }))
  default = []
}

variable "subnets" {
  type        = list(string)
  description = "List of subnets (preferably private subnets)"
}

variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be created"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  # The current version is tested and compatible with the below EKS addons versions
  default = "1.30"
}

variable "eks_oidc_idp" {
  description = "The OIDC configuration for the eks cluster, how to authenticate to it"
  type = map(object({
    client_id      = string
    issuer_url     = string
    groups_claim   = string
    username_claim = string
  }))
  default = {
  }
}

variable "cluster_security_group_additional_rules" {
  description = "Additional rules to add to the EKS cluster security group"
  type = map(object({
    description                   = string
    protocol                      = string
    from_port                     = number
    to_port                       = number
    type                          = string
    source_security_group_id      = optional(string)
    source_cluster_security_group = optional(bool, false)
    cidr_blocks                   = optional(list(string))
  }))
  default = {
  }

}

variable "extra_node_security_groups_rules" {
  description = "List of extra security groups rules for the EKS nodes"
  type = map(object({
    description                   = string
    protocol                      = string
    from_port                     = number
    to_port                       = number
    type                          = string
    source_security_group_id      = optional(string)
    source_cluster_security_group = optional(bool, false)
    cidr_blocks                   = optional(list(string))
  }))
  default = {
  }

}

variable "cluster_endpoint_public_access_cidrs" {
  description = "The CIDR block to allow access to the EKS cluster"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_endpoint_public_access" {
  description = "Indicates if the public access to the EKS cluster is enabled"
  type        = bool
  default     = true
}

variable "aws-ebs-csi-driver-version" {
  description = "The version of the AWS EBS CSI driver to install"
  type        = string
  # default     = "v1.36.0-eksbuild.1"
  default = "v1.34.0-eksbuild.1"
}

variable "vpc-cni-version" {
  description = "The version of the VPC CNI to install"
  type        = string
  default     = "v1.18.6-eksbuild.1"
}

variable "aws-coredns-driver-version" {
  description = "The version of CoreDNS to install"
  type        = string
  default     = "v1.11.3-eksbuild.2"
}

variable "aws-kube-proxy-driver-version" {
  description = "The version of the kube-proxy to install"
  type        = string
  default     = "v1.30.6-eksbuild.2"
}

variable "tags" {
  type        = map(string)
  description = "falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "falcosecurity-for-cloud"
  }
}
