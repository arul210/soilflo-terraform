variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_region" {
  type        = string
  description = "Default GCP region"
  default     = "northamerica-northeast2"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC network" 
}

variable "db_backup_bucket_name" {
  description = "Name of the database backup GCS bucket"
  type        = string
}

variable "db_backup_bucket_location" {
  description = "Location of the database backup GCS bucket"
  type        = string
}

variable "postgres_instance_name" {
  description = "Cloud SQL PostgreSQL instance name"
  type        = string
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}