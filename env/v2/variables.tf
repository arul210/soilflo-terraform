variable "gcp_project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "The GCP region"
  type = string
}

variable "db_backup_bucket_name" {
  description = "Name of the database backup GCS bucket"
  type        = string
}

variable "db_backup_bucket_location" {
  description = "Location of the database backup GCS bucket"
  type        = string
}

variable "private_network" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "postgres_instance_name" {
  type = string
}

variable "db_name" {
  type = string
}

variable "db_user" {
  type = string
}
