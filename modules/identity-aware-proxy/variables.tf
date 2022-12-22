/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
variable "project_id" {
  description = "Project id where the keyring will be created."
  type        = string
}
variable "iap_ocs_support_email" {
  description = "IAP OAuth consent screen support email address"
  type = string
  default = null
}
variable "iap_ocs_app_title" {
  description = "IAP OAuth consent screen app title"
  type = string
  default = null
}
variable "iap_client_name" {
  description = "IAP OAuth consent screen client id and secret name"
    type = string
}
variable "test_iap_brand_name" {
  description = "IAP Brand name that was created manually. To list brands use the gcloud command: gcloud iap oauth-brands list --project=PROJECT_ID"
  type = string
}
variable "test_acm_policy_name" {
  description = "Access Context Manager policy that was created manually. To list acm policy use the gcloud command: gcloud access-context-manager policies list --organization=ORG_ID"
  type = string
  default  = null
}
