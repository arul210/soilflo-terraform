variable "scheduler_job_name" {
  description = "Name of the Cloud Scheduler job"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region to deploy the Cloud Scheduler job"
  type        = string
  default     = "us-central1"
}

variable "schedule" {
  description = "Cron schedule (e.g., '0 0 * * *' for daily at midnight)"
  type        = string
}

variable "time_zone" {
  description = "Time zone"
  type        = string
  default     = "Etc/UTC"
}

variable "pubsub_topic_id" {
  description = "The fully qualified Pub/Sub topic ID"
  type        = string
}

variable "postgres_instance_name" {
  description = "The name of the Cloud SQL instance to back up"
  type        = string
}

variable "cloudfunction_sa" {
  description = "Service account email for the Cloud Function that will use this scheduler job"
  type        = string
}