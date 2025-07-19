variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "gcp_region" {
  type        = string
  description = "Region to deploy the artifact registry"
}

variable "docker_repo_name" {
  type        = string
  description = "Name of the artifact repository"
}
