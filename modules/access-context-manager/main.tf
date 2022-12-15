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

resource "google_compute_instance_group" "unmanaged" {
  project     = var.project_id
  zone        = var.zone
  name        = var.name
  description = "Terraform-managed."
  instances   = var.instances
  dynamic "named_port" {
    for_each = var.named_ports != null ? var.named_ports : {}
    iterator = config
    content {
      name = config.key
      port = config.value
    }
  }
}