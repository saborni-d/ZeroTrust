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

variable "lb_backend_prefix" {
  description = "Prefix for the backend service name"
  type = string
}
variable "lb_ssl_policy_name" {
  description = "Name of the load balancer SSL policy"
  type = string
}
variable "lb_ssl_policy_profile" {
  description = "Profile of the load balancer SSL policy. Possible values are COMPATIBLE, MODERN, RESTRICTED, and CUSTOM. GCP recommends using MODERN and RESTRICTED profiles"
  type = string
}
variable "lb_ssl_policy_min_tls_version" {
  description = "Minimum TLS version used in the load balancer SSL policy. Possible values are TLS_1_0, TLS_1_1, and TLS_1_2. GCP recommends using TLS_1_2"
  type = string
}
variable "lb_target_tags" {
  description = "Network tags that need to targetted for health check"
  type = list(string)
  default = []
}
variable "lb_managed_ssl_cert_domains" {
  description = "Subdomain name for the load balancer Google managed SSL certificates. E.g. test-app.example.com"
  type = list(string)
}
variable "lb_url_map_hosts" {
  description = "Subdomain name for the load balancer Frontend/URL map. E.g. test-app.example.com"
  type = list(string)
  default = []
}
variable "lb_url_map_name" {
  description = "Name of the load balancer URL map"
  type = string
}
variable "lb_hc_fw_networks" {
  description = "VPC network in which the load balancer health check firewall needs to be created"
  type = list(string)
  default = []
}
variable "lb_backend_config" {
  description = "Map backend indices to list of backend maps."
  type = map(object({
    protocol  = string
    port      = number
    port_name = string

    description             = string
    enable_cdn              = bool
    compression_mode        = string
    security_policy         = string
    custom_request_headers  = list(string)
    custom_response_headers = list(string)

    timeout_sec                     = number
    connection_draining_timeout_sec = number
    session_affinity                = string
    affinity_cookie_ttl_sec         = number

    health_check = object({
      check_interval_sec  = number
      timeout_sec         = number
      healthy_threshold   = number
      unhealthy_threshold = number
      request_path        = string
      port                = number
      host                = string
      logging             = bool
    })

    log_config = object({
      enable      = bool
      sample_rate = number
    })

    groups = list(object({
      group = string

      balancing_mode               = string
      capacity_scaler              = number
      description                  = string
      max_connections              = number
      max_connections_per_instance = number
      max_connections_per_endpoint = number
      max_rate                     = number
      max_rate_per_instance        = number
      max_rate_per_endpoint        = number
      max_utilization              = number
    }))
    iap_config = object({
      enable               = optional(bool)
      oauth2_client_id     = optional(string)
      oauth2_client_secret = optional(string)
    })
  }))
}
variable "lb_url_map_config" {
  description = "A configuration of the backends and path rules"
  type = map(list(string))
}
