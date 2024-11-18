# AWS VPC Module

This module provides the configuration to set up a VPC based on the `terraform-aws-modules/vpc/aws` official module.

<!-- BEGIN_TF_DOCS -->
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.76.0 |

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.19.0 |

## Usage

The basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "<module-path>"

	 # Required variables
	 name  =

	 # Optional variables
	 cidr_block  = "10.0.0.0/16"
	 private_subnets  = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]
	 public_subnets  = [
  "10.0.4.0/24",
  "10.0.5.0/24"
]
	 tags  = {
  "product": "falcosecurity-for-cloud"
}
}
```

## Resources

| Name | Type |
|------|------|
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | The CIDR block for the VPC | `string` | `"10.0.0.0/16"` | no |
| <a name="input_name"></a> [name](#input\_name) | VPC name | `string` | n/a | yes |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | The private subnets. If you are enabling the VPC module. | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | The public subnets. If you are enabling the VPC module. | `list(string)` | <pre>[<br>  "10.0.4.0/24",<br>  "10.0.5.0/24"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning | `map(string)` | <pre>{<br>  "product": "falcosecurity-for-cloud"<br>}</pre> | no |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | 5.1.1 |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnets_details"></a> [private\_subnets\_details](#output\_private\_subnets\_details) | List of private subnets details |
| <a name="output_private_subnets_ids"></a> [private\_subnets\_ids](#output\_private\_subnets\_ids) | List of private subnets |
| <a name="output_public_subnets_details"></a> [public\_subnets\_details](#output\_public\_subnets\_details) | List of public subnets details |
| <a name="output_public_subnets_ids"></a> [public\_subnets\_ids](#output\_public\_subnets\_ids) | List of public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The VPC ID where the EKS cluster will be created |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. See LICENSE for full details.
