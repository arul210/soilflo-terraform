output "docker_repo_url" {
  value       = "${var.gcp_region}-docker.pkg.dev/${var.gcp_project_id}/${var.docker_repo_name}/"
  description = "Docker repository URL"
}