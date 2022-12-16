resource "google_secret_manager_secret" "iap_client_id" {
  secret_id = var.iap_client_id
  project = google_project_service.enable_project_apis.project
  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret" "iap_client_secret" {
  secret_id = var.iap_client_secret
  project = google_project_service.enable_project_apis.project
  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "iap_client_id_version" {
  secret = google_secret_manager_secret.iap_client_id.id
  secret_data = google_iap_client.iap_client_creds.client_id
}
resource "google_secret_manager_secret_version" "iap_client_secret_version" {
  secret = google_secret_manager_secret.iap_client_secret.id
  secret_data = google_iap_client.iap_client_creds.secret
}
