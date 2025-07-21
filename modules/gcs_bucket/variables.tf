variable "bucket_name" {
  type        = string
  description = "GCS DB Backup bucket name used for database backups"
}

variable "gcp_region" {
  type        = string
  description = "Region where the GCS DB Backup bucket will be created"
}

variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID where the bucket will be created"
}

variable "storage_class" {
  type        = string
  description = "GCS storage class to use for the DB Backup bucket"
  default     = "ARCHIVE"
}

variable "versioning" {
  type        = bool
  description = "Whether object versioning should be enabled on the bucket"
  default     = true
}

variable "num_newer_versions" {
  type        = number
  description = "Number of newer versions required before deleting an archived object"
  default     = 3
}

variable "cloudfunction_sa" {
  type        = string
  description = "Service account email for the Cloud Function that will use this bucket"
}