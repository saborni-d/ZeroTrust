#TODO: Add file description
#TODO: add proper comments wherever needed
locals {
  backends = {
    for key,value in var.lb_backend_config:
      key => merge(value, {
        iap_config = {
          enable               = true
          oauth2_client_id     = google_secret_manager_secret_version.iap_client_id_version.secret_data #TODO: replace with secret manager
          oauth2_client_secret = google_secret_manager_secret_version.iap_client_secret_version.secret_data #TODO: replace with secret manager
        }
        }
      )
  }
}


module "gce_lb_https" {
  source  = "GoogleCloudPlatform/lb-http/google"
  version = "~> 6.0"
  name    = var.lb_backend_prefix
  project = google_project_service.enable_project_apis.project
  target_tags = var.lb_target_tags
  firewall_networks = var.lb_hc_fw_networks
  url_map           = google_compute_url_map.gce_lb_https_url_map.self_link
  create_url_map    = false
  ssl               = true
  ssl_policy = google_compute_ssl_policy.modern-ssl-policy.self_link
  use_ssl_certificates = false
  managed_ssl_certificate_domains = var.lb_managed_ssl_cert_domains
  backends = local.backends
}

#Creating URL map for differentiating between mig and gae backends
resource "google_compute_url_map" "gce_lb_https_url_map" {
  // note that this is the name of the load balancer
  name            = var.lb_url_map_name
  project = google_project_service.enable_project_apis.project
  default_service = module.gce_lb_https.backend_services[keys(var.lb_url_map_config)[0]].self_link #TODO: due to map being unordered, this takes alphabetically 1st backend as the default one. Having extra "default" service will solve this but then we will have 3 backends
  host_rule {
    hosts        = var.lb_url_map_hosts
    path_matcher = "test"
  }
  path_matcher {
    name            = "test"
    default_service = module.gce_lb_https.backend_services[keys(var.lb_url_map_config)[0]].self_link #TODO: due to map being unordered, this takes alphabetically 1st backend as the default one. Having extra "default" service will solve this but then we will have 3 backends
    dynamic "path_rule" {
      for_each = var.lb_url_map_config
      content {
        paths = path_rule.value
        service = module.gce_lb_https.backend_services[path_rule.key].self_link
      }
    }
  }
}

resource "google_compute_ssl_policy" "modern-ssl-policy" {
  name            = var.lb_ssl_policy_name
  project = google_project_service.enable_project_apis.project
  profile         = var.lb_ssl_policy_profile
  min_tls_version = var.lb_ssl_policy_min_tls_version
}
