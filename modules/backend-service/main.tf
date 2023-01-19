resource "google_compute_backend_service" "backend-service" {
  name                  = var.backend_service_name
  project               = var.project_id
  health_checks         = [var.health_check]
  load_balancing_scheme = "EXTERNAL"            #Global HTTPS LB classic
  port_name             = var.backend_port_name #"http"
  protocol              = var.backend_protocol  #"HTTP"
  backend {
    group = var.backend_group_url #"https://www.googleapis.com/compute/v1/projects/phonic-sunbeam-372811/zones/asia-south1-c/instanceGroups/instance-group-1"
  }
  iap {
    oauth2_client_id     = var.oauth2_client_id
    oauth2_client_secret = var.oauth2_client_secret
  }
}