variable "managed_ssl_cert_name" {
  description = "Managed SSL certificate name"
  type        = string
}
variable "lb_domain" {
  description = "DNS/Domain name used for the load balancer"
  type        = string
}
variable "lb_https_proxy_name" {
  description = "Load Balancer https proxy name"
  type        = string
}
variable "lb_name" {
  description = "Name of the https external global load balancer"
  type        = string
}
variable "backend_service_id" {
  description = "ID of the load balancer backend service"
  type        = string
}
variable "paths_list" {
  description = "list of paths for load balancer URL map"
  type        = list(string)
}
variable "lb_fw_rule_name" {
  description = "Name of the load balancer forwarding rule"
  type        = string
}
variable "lb_fw_ip_protocol" {
  description = "IP protocol for the lb fw rule"
  type        = string
}
variable "project_id" {
  description = "GCP project ID where the lb resources need to be created"
  type        = string
}
variable "lb_scheme" {
  description = "Load balancing scheme"
  type        = string
}
variable "lb_fw_port_range" {
  description = "Port range of the lb fw rule"
  type        = string
}