resource "google_artifact_registry_repository" "docker_repo" {
  project       = var.gcp_project_id
  location      = var.gcp_region
  repository_id = var.docker_repo_name
  format        = "DOCKER"
  description   = "Docker repo"
}
