variable "neg_name" {
  description = "Network Endpoint Group Name"
  type = string
}
variable "neg_vpc_network_id" {
  description = "Network Endpoint Group VPC Network Name"
  type = string
}

variable "neg_default_port" {
  description = "Network Endpoint Group Port"
  type = string
}

variable "neg_zone" {
  description = "Network Endpoint Group Zone"
  type = string
}

variable "neg_endpoint_type" {
  description = "Network Endpoint Group Type"
  type = string
}

variable "neg_endpoint_ip" {
  description = "Network Endpoint Group IP Address ( This IP should be IP address of the on-prem/multi cloud server that is accessible via VPN connectivity through the mentioned VPC)"
  type = string
}

