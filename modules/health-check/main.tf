resource "google_compute_health_check" "tcp-health-check" {
  name                = var.health_check_name #"tcp-health-check"
  project             = var.project_id
  timeout_sec         = var.timeout_sec #5
  check_interval_sec  = var.check_interval_sec #5
  healthy_threshold   = var.healthy_threshold #2
  unhealthy_threshold = var.unhealthy_threshold #2
  tcp_health_check {
    port = var.health_check_port #"80"
  }
}