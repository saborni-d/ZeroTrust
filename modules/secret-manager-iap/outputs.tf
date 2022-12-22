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

output "oauth2_client_id" {
  description = "OAUTH2 Client ID."
  value       = google_secret_manager_secret_version.iap_client_id_version.secret_data
}
   
   output "oauth2_client_secret" {
  description = "OAUTH2 Client Secret."
  value       = google_secret_manager_secret_version.iap_client_secret_version.secret_data
}


