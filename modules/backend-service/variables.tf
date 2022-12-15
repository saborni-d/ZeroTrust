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

variable "address" {
  description = "Optional IP address used for the forwarding rule."
  type        = string
  default     = null
}

variable "global_access" {
  description = "Global access, defaults to false if not set."
  type        = bool
  default     = true //allowing access from all regions as default behaviour
}

variable "labels" {
  description = "Labels set on resources."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name used for all resources."
  type        = string
}

variable "network" {
  description = "Network used for resources."
  type        = string
}

variable "ports" {
  description = "Comma-separated ports, leave null to use all ports."
  type        = list(string)
  default     = null
}

variable "project_id" {
  description = "Project id where resources will be created."
  type        = string
}

variable "protocol" {
  description = "IP protocol used, defaults to TCP."
  type        = string
  default     = "TCP"
}

variable "region" {
  description = "GCP region."
  type        = string
}

variable "service_label" {
  description = "Optional prefix of the fully qualified forwarding rule name."
  type        = string
  default     = null
}

variable "subnetwork" {
  description = "Subnetwork used for the forwarding rule."
  type        = string
}

variable "backend_service" {
  description = "Self link for the backend service associated with the ILB"
  type        = string
}