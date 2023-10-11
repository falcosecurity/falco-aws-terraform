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

#---------------------------------
# optionals - with defaults
#---------------------------------

#
# module composition
#

variable "is_organizational" {
  type        = bool
  default     = false
  description = "whether falcosecurity-for-cloud should be deployed in an organizational setup"
}


variable "organizational_config" {
  type = object({
    falcosecurity_for_cloud_member_account_id = string
    organizational_role_per_account           = string
  })
  default = {
    falcosecurity_for_cloud_member_account_id = null
    organizational_role_per_account           = null
  }
  description = <<-EOT
    organizational_config. following attributes must be given
    <ul><li>`falcosecurity_for_cloud_member_account_id` to enable reading permission</li>
    <li>`organizational_role_per_account` to enable SNS topic subscription. by default "OrganizationAccountAccessRole"</li></ul>
  EOT
}

#
# module config
#

variable "s3_bucket_expiration_days" {
  type        = number
  default     = 5
  description = "Number of days that the logs will persist in the bucket"
}

variable "cloudtrail_kms_enable" {
  type        = bool
  default     = true
  description = "true/false whether s3 should be encrypted"
}

variable "is_multi_region_trail" {
  type        = bool
  default     = true
  description = "true/false whether cloudtrail will ingest multiregional events"
}


#
# general
#

variable "name" {
  type        = string
  default     = "ffc"
  description = "Name to be assigned to all child resources. A suffix may be added internally when required. Use default value unless you need to install multiple instances"
}

variable "tags" {
  type        = map(string)
  description = "falcosecurity-for-cloud tags. always include 'product' default tag for resource-group proper functioning"
  default = {
    "product" = "falcosecurity-for-cloud"
  }
}
