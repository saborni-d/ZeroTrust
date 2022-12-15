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

resource "google_compute_forwarding_rule" "default" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.name
  description           = "Terraform managed."
  load_balancing_scheme = "INTERNAL"
  region                = var.region
  network               = var.network
  subnetwork            = var.subnetwork
  ip_address            = var.address
  ip_protocol           = var.protocol # TCP | UDP
  ports                 = var.ports    # "nnnnn" or "nnnnn,nnnnn,nnnnn" max 5
  service_label         = var.service_label
  all_ports             = var.ports == null ? true : null
  allow_global_access   = var.global_access
  backend_service       = var.backend_service
  labels                = var.labels
}