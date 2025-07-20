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

variable "message_payload" {
  description = "The message payload to send to the Pub/Sub topic"
  type        = string
  default     = "{}"
}
