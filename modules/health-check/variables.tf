variable "health_check_name" {
  description = "Name of the health check"
  type = string
}
variable "health_check_port" {
  description = "Health check port"
  type = string
}
variable "project_id" {
  description = "GCP project where health check needs to be created"
  type = string
}
variable "timeout_sec" {
  description = "health check timeout seconds"
  type = number
}
variable "check_interval_sec" {
  description = "health check interval seconds"
  type = number
}
variable "healthy_threshold" {
  description = "health check healthy threshold"
  type = number
}
variable "unhealthy_threshold" {
  description = "health check unhealthy threshold"
  type = number
}
