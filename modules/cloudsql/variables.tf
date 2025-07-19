variable "postgres_instance_name" {
  description = "Cloud SQL PostgreSQL instance name"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for the Cloud SQL instance"
  type        = string
}

variable "private_network" {
  description = "VPC network for private IP connectivity"
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