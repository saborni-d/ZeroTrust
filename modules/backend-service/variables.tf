variable "backend_service_name" {
  description = "Name of the lb backend service"
  type = string
}
variable "project_id" {
  description = "GCP project where the backend service needs to be created"
  type = string
}
variable "health_check" {
  description = "Health check for the backend service"
  type = optional(string)
}
variable "backend_port_name" {
  description = "Name of port name used in Instance groups"
  type = string
}
variable "backend_protocol" {
  description = "backend service protocol"
  type = string
}
variable "backend_group_url" {
  description = "The fully-qualified URL of an Instance Group or Network Endpoint Group resource"
  type = string
}
variable "oauth2_client_id" {
  description = "OAuth2 Client ID for IAP"
  type = string
}
variable "oauth2_client_secret" {
  description = "OAuth2 Client Secret for IAP"
  type = string
}
