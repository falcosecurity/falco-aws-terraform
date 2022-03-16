output "cloudtrail_sns_subscribed_sqs_url" {
  value       = module.sqs_sns_subscription.cloudtrail_sns_subscribed_sqs_url
  description = "URL of the cloudtrail-sns subscribed sqs"
}

output "cloudtrail_sns_subscribed_sqs_arn" {
  value       = module.sqs_sns_subscription.cloudtrail_sns_subscribed_sqs_arn
  description = "ARN of the cloudtrail-sns subscribed sqs"
}
