resource "google_compute_managed_ssl_certificate" "default" {
  name    = var.managed_ssl_cert_name
  project = var.project_id

  managed {
    domains = [var.lb_domain]
  }
}

resource "google_compute_target_https_proxy" "default" {
  name             = var.lb_https_proxy_name
  project          = var.project_id
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_url_map" "default" {
  name            = var.lb_name
  project         = var.project_id
  default_service = var.backend_service_id

  host_rule {
    hosts        = [var.lb_domain]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = var.backend_service_id

    path_rule {
      paths   = var.paths_list #["/*"]
      service = var.backend_service_id
    }
  }
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = var.lb_fw_rule_name
  project               = var.project_id
  ip_protocol           = var.lb_fw_ip_protocol #"TCP"
  load_balancing_scheme = var.lb_scheme         #"EXTERNAL"
  port_range            = var.lb_fw_port_range  #"443"
  target                = google_compute_target_https_proxy.default.id
}