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

locals {
  health_check = (
    var.health_check != null
    ? var.health_check
    : try(local.health_check_resource.self_link, null)
  )
  health_check_resource = try(
    google_compute_health_check.http.0,
    google_compute_health_check.https.0,
    google_compute_health_check.tcp.0,
    google_compute_health_check.ssl.0,
    {}
  )
  health_check_type = try(var.health_check_config.type, null)
}

resource "google_compute_region_backend_service" "default" {
  provider              = google-beta
  project               = var.project_id
  name                  = var.name
  description           = "Terraform managed."
  load_balancing_scheme = "INTERNAL"
  region                = var.region
  network               = var.network
  health_checks         = [local.health_check]
  protocol              = var.protocol

  dynamic "backend" {
    for_each = { for b in var.backends : b => b }
    iterator = backend
    content {
      group = backend.key
    }
  }

}

resource "google_compute_health_check" "http" {
  provider = google-beta
  count = (
    var.health_check == null && local.health_check_type == "http" ? 1 : 0
  )
  project     = var.project_id
  name        = var.name
  description = "Terraform managed."

  http_health_check {
    port = try(var.health_check_config.port, null)
  }
}

resource "google_compute_health_check" "https" {
  provider = google-beta
  count = (
    var.health_check == null && local.health_check_type == "https" ? 1 : 0
  )
  project     = var.project_id
  name        = var.name
  description = "Terraform managed."

  https_health_check {
    port = try(var.health_check_config.port, null)
  }
}

resource "google_compute_health_check" "tcp" {
  provider = google-beta
  count = (
    var.health_check == null && local.health_check_type == "tcp" ? 1 : 0
  )
  project     = var.project_id
  name        = var.name
  description = "Terraform managed."

  tcp_health_check {
    port = try(var.health_check_config.port, null)
  }

}

resource "google_compute_health_check" "ssl" {
  provider = google-beta
  count = (
    var.health_check == null && local.health_check_type == "ssl" ? 1 : 0
  )
  project     = var.project_id
  name        = var.name
  description = "Terraform managed."

  ssl_health_check {
    port = try(var.health_check_config.port, null)
  }
}
