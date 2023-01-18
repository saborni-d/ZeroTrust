resource "google_secret_manager_secret" "iap_client_id" {
  secret_id = var.iap_client_id
  project = var.project_id
  replication {
    automatic = true
  }
}
resource "google_secret_manager_secret" "iap_client_secret" {
  secret_id = var.iap_client_secret
  project = var.project_id
  replication {
    automatic = true
  }
}


resource "google_secret_manager_secret_version" "iap_client_id_version" {
  secret = google_secret_manager_secret.iap_client_id.id
  secret_data = var.client_id
}
resource "google_secret_manager_secret_version" "iap_client_secret_version" {
  secret = google_secret_manager_secret.iap_client_secret.id
  secret_data = var.client_secret
}
