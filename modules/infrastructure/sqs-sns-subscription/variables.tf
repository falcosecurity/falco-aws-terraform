variable "name" {
  type        = string
  description = "Queue name"
}

variable "sns_topic_arn" {
  type        = string
  description = "CloudTrail SNS Topic ARN to subscribe the SQS queue"
}

variable "tags" {
  type        = map(string)
  description = "falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "falcosecurity-for-cloud"
  }
}
