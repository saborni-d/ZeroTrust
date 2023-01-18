resource "google_compute_network_endpoint_group" "neg" {
  name                  = var.neg_name
  network               = var.neg_vpc_network_id
  default_port          = var.neg_default_port
  zone                  = var.neg_zone
  network_endpoint_type = var.neg_endpoint_type
}

resource "google_compute_network_endpoint" "default-endpoint" {
  network_endpoint_group = google_compute_network_endpoint_group.neg.name
  port = google_compute_network_endpoint_group.neg.default_port
  ip_address = var.neg_endpoint_ip
}
