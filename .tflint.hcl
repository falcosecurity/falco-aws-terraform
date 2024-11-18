config {

}

plugin "aws" {
    enabled = true
    version = "0.35.0"
    source  = "github.com/terraform-linters/tflint-ruleset-aws"
}

rule "aws_resource_missing_tags" {
  enabled = true
  tags = [
    "product",
  ]
}
