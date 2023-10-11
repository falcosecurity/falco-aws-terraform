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

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
resource "aws_cloudtrail" "cloudtrail" {

  name = var.name

  is_organization_trail = var.is_organizational

  s3_bucket_name        = aws_s3_bucket.cloudtrail.id
  is_multi_region_trail = var.is_multi_region_trail

  kms_key_id     = var.cloudtrail_kms_enable ? aws_kms_key.cloudtrail_kms[0].arn : null
  sns_topic_name = aws_sns_topic.cloudtrail.id

  enable_logging                = true
  enable_log_file_validation    = true
  include_global_service_events = true

  tags = var.tags

  ## note: seems required to avoid raicing conditions (InsufficientSnsTopicPolicyException on cloudtrail creation) /shrug
  depends_on = [aws_s3_bucket_policy.cloudtrail_s3, aws_sns_topic_policy.allow_cloudtrail_publish]
}

data "aws_caller_identity" "me" {}
