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

variable "delete_contents_on_destroy" {
  type        = bool
  description = "Whether to delete contents when destroying the dataset"
  default     = false
}

variable "bigquery_dataset_id" {
  type        = string
  description = "Dataset ID"
}

variable "cloudrun_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "image" {
  description = "Docker image to deploy"
  type        = string
}

variable "timeout" {
  description = "Container timeout duration (e.g., 300s)"
  type        = string
}

variable "limits" {
  description = "CPU and memory limits for the container"
  type = object({
    cpu    = string
    memory = string
  })
}

variable "startup" {
  description = "Startup probe configuration"
  type = object({
    port                = number
    initial_delay_seconds = number
    timeout_seconds       = number
    failure_threshold     = number
  })
}

variable "scaling" {
  description = "Auto-scaling configuration"
  type = object({
    min_instances = number
    max_instances = number
  })
}

variable "max_instance_request_concurrency" {
  description = "Maximum number of concurrent requests per container instance"
  type        = number
  default     = 80
}

variable "cloudrun_sa" {
  description = "Email of the service account used by Cloud Run"
  type        = string
}

variable "topic_name" {
  description = "Name of the Pub/Sub topic to trigger the DB backup function"
  type        = string
}

variable "scheduler_job_name" {
  description = "Name of the Cloud Scheduler job"
  type        = string
}

variable "schedule" {
  description = "Cron schedule for the Cloud Scheduler job"
  type        = string
  default     = "0 3 * * *" # 3 AM daily
}

variable "time_zone" {
  description = "Timezone for the scheduler job"
  type        = string
  default     = "America/Toronto"
}

variable "function_bucket_name" {
  description = "GCS bucket name where Cloud Function source code is stored"
  type        = string
}

variable "cloudfunction_sa" {
  description = "Service account email used by Cloud Function"
  type        = string
}

variable "db_backup_cloudfunction_name" {
  description = "Name of the Cloud Function that performs DB backup"
  type        = string
}

variable "db_backup_function_source_dir" {
  description = "Local path to the DB Backup Cloud Function source code zip files"
  type        = string
}

variable "db_backup_function_env_vars" {
  description = "Environment variables for DB Backup Cloud function"
  type        = map(string)
  default     = {}
}

variable "db_backup_config" {
  description = "DB Backup Cloud Function configuration parameters"
  type = object({
    runtime                 = string
    entry_point             = string
    max_instances           = number
    min_instances           = number
    memory                  = string
    cpu                     = number
    timeout                 = number
    max_request_concurrency = number
  })
}

variable "check_hauling_summary_function_name" {
  description = "Name of the check hauling summary Cloud Function"
  type        = string
}

variable "check_hauling_summary_function_source_dir" {
  description = "Local path to the Check Hauling Summary Cloud Function source code zip files"
  type        = string
}

variable "check_hauling_summary_function_env_vars" {
  description = "Environment variables for check hauling Cloud function"
  type        = map(string)
  default     = {}
}

variable "check_hauling_config" {
  description = "Cloud Function configuration for check hauling"
  type = object({
    runtime                 = string
    entry_point             = string
    max_instances           = number
    min_instances           = number
    memory                  = string
    cpu                     = number
    timeout                 = number
    max_request_concurrency = number
  })
}

variable "html_to_pdf_function_name" {
  description = "Name of the html to pdf Cloud Function"
  type        = string
}

variable "html_to_pdf_function_source_dir" {
  description = "Local path to the html to pdf Cloud Function source code zip files"
  type        = string
}

variable "html_to_pdf_function_env_vars" {
  description = "Environment variables for html to pdf Cloud function"
  type        = map(string)
  default     = {}
}

variable "html_to_pdf_function_config" {
  description = "Cloud Function configuration for html to pdf"
  type = object({
    runtime                 = string
    entry_point             = string
    max_instances           = number
    min_instances           = number
    memory                  = string
    cpu                     = number
    timeout                 = number
    max_request_concurrency = number
  })
}
