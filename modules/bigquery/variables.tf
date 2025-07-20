variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "bigquery_dataset_id" {
  type        = string
  description = "Dataset ID"
}

variable "gcp_region" {
  type        = string
  description = "Region for the dataset"
}

variable "delete_contents_on_destroy" {
  type        = bool
  description = "Whether to delete contents when destroying the dataset"
  default     = false
}
