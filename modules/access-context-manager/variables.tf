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

# variable "group_configs" {
#   description = "Optional unmanaged groups to create. Can be referenced in backends via outputs."
#   type = map(object({
#     instances   = list(string)
#     named_ports = map(number)
#     zone        = string
#   }))
#   default = {}
# }

variable "project_id" {
  description = "Project id where resources will be created."
  type        = string
}

variable "instances" {
  description = "List of instances which are part of the unmanaged instance group"
  type        = list(string)
  default     = []
}

variable "named_ports" {
  description = "List of named ports of the unmanaged instance group"
  type        = map(number)
  default     = {}
}

variable "zone" {
  description = "List of instances which are part of the unmanaged instance group"
  type        = string
  default     = null
}

variable "name" {
  description = "Name used for all resources."
  type        = string
}