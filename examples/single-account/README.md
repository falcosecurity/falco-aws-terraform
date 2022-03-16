# Connect Falco To Cloudtrail Resources in AWS<br/>[ Example :: Single-Account ]

Deploy A [Falco](https://github.com/falcosecurity/falco) [cloudtrail](https://github.com/falcosecurity/plugins/tree/master/plugins/cloudtrail) plugin input in a single AWS account.<br/>
All the required resources and workloads will be run under the same account.

## Prerequisites

Minimum requirements:

1. Configure [Terraform **AWS** Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Notice

* **Resource creation inventory** Find all the resources created by this example in the resource-group `falcosecurity-for-cloud` (AWS Resource Group & Tag Editor) <br/><br/>
* **Deployment cost** This example will create resources that cost money.<br/>Run `terraform destroy` when you don't need them anymore


## Usage

For quick testing, use this snippet on your terraform files

```terraform
terraform {
   required_providers {
   }
}

provider "aws" {
   region = "<AWS-REGION>; ex. us-east-1"
}

module "falcosecurity_for_cloud_aws_single_account" {
   source = "falcosecurity/falcosecurity-for-cloud/aws/examples/single-account"
}
```

See [inputs summary](#inputs) or module [`variables.tf`](https://github.com/falcosecurity/falco-cloudtrail-terraform/blob/master/examples/single-account/variables.tf) file for more optional configuration.

To run this example you need have your [aws account profile configured in CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) and to execute:
```terraform
$ terraform init
$ terraform plan
$ terraform apply
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.15.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |

## Providers

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudtrail"></a> [cloudtrail](#module\_cloudtrail) | ../../modules/infrastructure/cloudtrail | n/a |
| <a name="module_sqs_sns_subscription"></a> [sqs_sns_subscription](#module\_sqs\_sns\_subscription) | ../../modules/infrastructure/sqs-sns-subscription | n/a |
| <a name="module_resource_group"></a> [resource\_group](#module\_resource\_group) | ../../modules/infrastructure/resource-group | n/a |

## Resources

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudtrail_is_multi_region_trail"></a> [cloudtrail\_is\_multi\_region\_trail](#input\_cloudtrail\_is\_multi\_region\_trail) | true/false whether cloudtrail will ingest multiregional events | `bool` | `true` | no |
| <a name="input_cloudtrail_kms_enable"></a> [cloudtrail\_kms\_enable](#input\_cloudtrail\_kms\_enable) | true/false whether cloudtrail delivered events to S3 should persist encrypted | `bool` | `true` | no |
| <a name="input_cloudtrail_sns_arn"></a> [cloudtrail\_sns\_arn](#input\_cloudtrail\_sns\_arn) | ARN of a pre-existing cloudtrail\_sns. If defaulted, a new cloudtrail will be created | `string` | `"create"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances | `string` | `"ffc"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | falcosecurity-for-cloud tags | `map(string)` | <pre>{<br>  "product": "falcosecurity-for-cloud"<br>}</pre> | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudtrail_sns_subscribed_sqs_arn"></a> [cloudtrail\_sns\_subscribed\_sqs\_arn](#output\_cloudtrail\_sns\_subscribed\_sqs\_arn) | ARN of the cloudtrail-sns subscribed sqs |
| <a name="output_cloudtrail_sns_subscribed_sqs_url"></a> [cloudtrail\_sns\_subscribed\_sqs\_url](#output\_cloudtrail\_sns\_subscribed\_sqs\_url) | URL of the cloudtrail-sns subscribed sqs |
<!-- END_TF_DOCS -->

## Authors

This was originally based on the [Terraform](https://github.com/sysdiglabs/terraform-aws-secure-for-cloud) module for Sysdig Secure.

## License

Apache 2 Licensed. See LICENSE for full details.
