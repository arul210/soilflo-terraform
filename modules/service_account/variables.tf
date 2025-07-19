variable "service_account_name" {
  type        = string
  description = "Service Account ID (without domain)"
}

variable "display_name" {
  type        = string
  description = "Service Account Display Name"
}

variable "gcp_project_id" {
  type        = string
  description = "GCP Project ID"
}