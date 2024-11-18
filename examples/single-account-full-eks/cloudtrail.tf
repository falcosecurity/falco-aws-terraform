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

module "cloudtrail" {
  count                 = local.cloudtrail_deploy ? 1 : 0
  source                = "../../modules/infrastructure/cloudtrail"
  name                  = var.name
  is_organizational     = false
  is_multi_region_trail = var.cloudtrail_is_multi_region_trail
  cloudtrail_kms_enable = var.cloudtrail_kms_enable

  tags = var.tags
}

