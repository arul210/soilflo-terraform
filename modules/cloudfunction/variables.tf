variable "gcp_project_id" {
  type        = string
  description = "GCP project ID"
}

variable "gcp_region" {
  type        = string
  description = "GCP region"
}

variable "cloudfunction_name" {
  type        = string
  description = "Name of the Cloud Function"
}

variable "function_bucket_name" {
  type        = string
  description = "GCS bucket with function source"
}

variable "source_dir" {
  description = "The source code directory for Cloud Function"
  type        = string
}

variable "config" {
  description = "Cloud Function configuration"
  type = object({
    runtime                 = string
    entry_point             = string
    min_instances           = number
    max_instances           = number
    memory                  = string
    cpu                     = number
    timeout                 = number
    max_request_concurrency = number
  })
}

variable "env_vars" {
  description = "Cloud Functions environment variables"
  type        = map(string)
}

variable "cloudfunction_sa" {
  description = "The Cloud Function service account email"
  type        = string
}

variable "trigger_type" {
  description = "Trigger type for the Cloud Function - 'pubsub' or 'http'"
  type        = string
}

variable "pubsub_topic" {
  description = "Pub/Sub topic name to trigger the function (required if trigger_type is 'pubsub')"
  type        = string
  default     = ""
}