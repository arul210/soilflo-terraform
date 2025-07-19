variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "platform_sa_email" {
  description = "Service account email to bind the custom role"
  type        = string
}