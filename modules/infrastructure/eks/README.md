# AWS Infra EKS Configuration

## Description

This module provides the configuration to set up an EKS cluster based on the `terraform-aws-modules/eks/aws` official module.

<!-- BEGIN_TF_DOCS -->
## Providers

No providers.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.19.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.4.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.0.0 |

## Usage

The basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 name  =
	 subnets  =
	 vpc_id  =

	 # Optional variables
	 acces_entries  = []
	 aws-coredns-driver-version  = "v1.11.3-eksbuild.2"
	 aws-ebs-csi-driver-version  = "v1.34.0-eksbuild.1"
	 aws-kube-proxy-driver-version  = "v1.30.6-eksbuild.2"
	 cluster_endpoint_public_access  = true
	 cluster_endpoint_public_access_cidrs  = [
  "0.0.0.0/0"
]
	 cluster_security_group_additional_rules  = {}
	 eks_oidc_idp  = {}
	 extra_node_security_groups_rules  = {}
	 instance_type  = "t2.medium"
	 k8s_version  = "1.30"
	 node_count  = 1
	 tags  = {
  "product": "falcosecurity-for-cloud"
}
	 vpc-cni-version  = "v1.18.6-eksbuild.1"
}
```

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acces_entries"></a> [acces\_entries](#input\_acces\_entries) | Map of access entries to add to the cluster | <pre>list(object({<br>    principal_arn     = string<br>    policy_arn        = string<br>    name              = string<br>    type              = string<br>    access_scope_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_aws-coredns-driver-version"></a> [aws-coredns-driver-version](#input\_aws-coredns-driver-version) | The version of CoreDNS to install | `string` | `"v1.11.3-eksbuild.2"` | no |
| <a name="input_aws-ebs-csi-driver-version"></a> [aws-ebs-csi-driver-version](#input\_aws-ebs-csi-driver-version) | The version of the AWS EBS CSI driver to install | `string` | `"v1.34.0-eksbuild.1"` | no |
| <a name="input_aws-kube-proxy-driver-version"></a> [aws-kube-proxy-driver-version](#input\_aws-kube-proxy-driver-version) | The version of the kube-proxy to install | `string` | `"v1.30.6-eksbuild.2"` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates if the public access to the EKS cluster is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | The CIDR block to allow access to the EKS cluster | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_cluster_security_group_additional_rules"></a> [cluster\_security\_group\_additional\_rules](#input\_cluster\_security\_group\_additional\_rules) | Additional rules to add to the EKS cluster security group | <pre>map(object({<br>    description                   = string<br>    protocol                      = string<br>    from_port                     = number<br>    to_port                       = number<br>    type                          = string<br>    source_security_group_id      = optional(string)<br>    source_cluster_security_group = optional(bool, false)<br>    cidr_blocks                   = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_eks_oidc_idp"></a> [eks\_oidc\_idp](#input\_eks\_oidc\_idp) | The OIDC configuration for the eks cluster, how to authenticate to it | <pre>map(object({<br>    client_id      = string<br>    issuer_url     = string<br>    groups_claim   = string<br>    username_claim = string<br>  }))</pre> | `{}` | no |
| <a name="input_extra_node_security_groups_rules"></a> [extra\_node\_security\_groups\_rules](#input\_extra\_node\_security\_groups\_rules) | List of extra security groups rules for the EKS nodes | <pre>map(object({<br>    description                   = string<br>    protocol                      = string<br>    from_port                     = number<br>    to_port                       = number<br>    type                          = string<br>    source_security_group_id      = optional(string)<br>    source_cluster_security_group = optional(bool, false)<br>    cidr_blocks                   = optional(list(string))<br>  }))</pre> | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The type of the instance nodes | `string` | `"t2.medium"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | Kubernetes version | `string` | `"1.30"` | no |
| <a name="input_name"></a> [name](#input\_name) | EKS cluster name | `string` | n/a | yes |
| <a name="input_node_count"></a> [node\_count](#input\_node\_count) | The minimun number of nodes to run in the cluster | `number` | `1` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets (preferably private subnets) | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning | `map(string)` | <pre>{<br>  "product": "falcosecurity-for-cloud"<br>}</pre> | no |
| <a name="input_vpc-cni-version"></a> [vpc-cni-version](#input\_vpc-cni-version) | The version of the VPC CNI to install | `string` | `"v1.18.6-eksbuild.1"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the EKS cluster will be created | `string` | n/a | yes |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 20.30.0 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudwatch_log_group_arn"></a> [cloudwatch\_log\_group\_arn](#output\_cloudwatch\_log\_group\_arn) | Arn of cloudwatch log group created |
| <a name="output_cloudwatch_log_group_name"></a> [cloudwatch\_log\_group\_name](#output\_cloudwatch\_log\_group\_name) | Name of cloudwatch log group created |
| <a name="output_cluster_addons"></a> [cluster\_addons](#output\_cluster\_addons) | Map of attribute maps for all EKS cluster addons enabled |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | The Amazon Resource Name (ARN) of the cluster |
| <a name="output_cluster_certificate_authority_data"></a> [cluster\_certificate\_authority\_data](#output\_cluster\_certificate\_authority\_data) | Base64 encoded certificate data required to communicate with the cluster |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for your Kubernetes API server |
| <a name="output_cluster_iam_role_arn"></a> [cluster\_iam\_role\_arn](#output\_cluster\_iam\_role\_arn) | IAM role ARN of the EKS cluster |
| <a name="output_cluster_iam_role_name"></a> [cluster\_iam\_role\_name](#output\_cluster\_iam\_role\_name) | IAM role name of the EKS cluster |
| <a name="output_cluster_iam_role_unique_id"></a> [cluster\_iam\_role\_unique\_id](#output\_cluster\_iam\_role\_unique\_id) | Stable and unique string identifying the IAM role |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The name/id of the EKS cluster. Will block on cluster creation until the cluster is really ready |
| <a name="output_cluster_identity_providers"></a> [cluster\_identity\_providers](#output\_cluster\_identity\_providers) | Map of attribute maps for all EKS identity providers enabled |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | The name of the EKS cluster |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_platform_version"></a> [cluster\_platform\_version](#output\_cluster\_platform\_version) | Platform version for the cluster |
| <a name="output_cluster_security_group_arn"></a> [cluster\_security\_group\_arn](#output\_cluster\_security\_group\_arn) | Amazon Resource Name (ARN) of the cluster security group |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication. Referred to as 'Cluster security group' in the EKS console |
| <a name="output_cluster_status"></a> [cluster\_status](#output\_cluster\_status) | Status of the EKS cluster. One of `CREATING`, `ACTIVE`, `DELETING`, `FAILED` |
| <a name="output_oidc_provider"></a> [oidc\_provider](#output\_oidc\_provider) | The OpenID Connect identity provider (issuer URL without leading `https://`) |
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | The ARN of the OIDC Provider if `enable_irsa = true` |
<!-- END_TF_DOCS -->
