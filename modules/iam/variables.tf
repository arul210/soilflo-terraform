variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "platform_sa" {
  description = "Service account email to bind the custom role"
  type        = string
}

variable "cloudrun_sa" {
  description = "Service account email to bind the Cloud Run"
  type        = string
}

variable "cloudfunction_sa" {
  description = "Service account email to bind the Cloud Function"
  type        = string
}
