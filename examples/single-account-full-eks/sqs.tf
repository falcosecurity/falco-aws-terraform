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

