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

output "cloudtrail_sns_subscribed_sqs_url" {
  value       = module.sqs_sns_subscription.cloudtrail_sns_subscribed_sqs_url
  description = "URL of the cloudtrail-sns subscribed sqs"
}

output "cloudtrail_sns_subscribed_sqs_arn" {
  value       = module.sqs_sns_subscription.cloudtrail_sns_subscribed_sqs_arn
  description = "ARN of the cloudtrail-sns subscribed sqs"
}

output "kubeconfig" {
  value       = "aws eks update-kubeconfig --name ${module.eks_cluster.cluster_name} --region ${var.aws_region}"
  description = "Commands to get the kubeconfig"
}

output "get_falcosidekick_local" {
  value       = "kubectl -n falco port-forward svc/falco-falcosidekick-ui 30282:$(kubectl get svc falco-falcosidekick-ui -n falco -o jsonpath='{.spec.ports[0].port}')"
  description = "Command to get the falcosidekick UI via port-forward"
}
