resource "google_service_account" "this" {
  account_id   = var.service_account_name
  display_name = var.display_name
  project      = var.gcp_project_id
}
