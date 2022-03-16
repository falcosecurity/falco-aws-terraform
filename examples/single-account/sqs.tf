locals {
  cloudtrail_deploy  = var.cloudtrail_sns_arn == "create"
  cloudtrail_sns_arn = local.cloudtrail_deploy ? module.cloudtrail[0].sns_topic_arn : var.cloudtrail_sns_arn
}

module "sqs_sns_subscription" {
  source        = "../../modules/infrastructure/sqs-sns-subscription"
  name          = var.name
  sns_topic_arn = local.cloudtrail_sns_arn
  tags          = var.tags
}

