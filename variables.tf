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

variable "bigquery_dataset_id" {
  type        = string
  description = "Dataset ID"
}

variable "delete_contents_on_destroy" {
  type        = bool
  description = "Whether to delete contents when destroying the dataset"
  default     = false
}

variable "core_cloudrun_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "core_image" {
  description = "Docker image to deploy"
  type        = string
}

variable "html_to_pdf_cloudrun_name" {
  description = "Name of the Cloud Run service"
  type        = string
}

variable "html_to_pdf_image" {
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

variable "db_backup_topic_name" {
  description = "Name of the Pub/Sub topic to trigger the DB backup function"
  type        = string
}

variable "db_backup_scheduler_job_name" {
  description = "Name of the Cloud Scheduler job"
  type        = string
}

variable "db_backup_schedule" {
  description = "Cron schedule for the Cloud Scheduler job"
  type        = string
  default     = "0 3 * * *" # 3 AM daily
}

variable "pgtobq_sync_topic_name" {
  description = "Name of the Pub/Sub topic to trigger the Postgres to Biquery Sync function"
  type        = string
}

variable "pgtobq_sync_scheduler_job_name" {
  description = "Name of the Cloud Scheduler job for Postgres to Biquery Sync"
  type        = string
}

variable "pgtobq_sync_schedule" {
  description = "Cron schedule for the Cloud Scheduler job for the Postgres to Biquery Sync"
  type        = string
  default     = "0 3 * * *" # 3 AM daily
}

variable "check_hauling_topic_name" {
  description = "Name of the Pub/Sub topic to trigger the Check Hauling Summary function"
  type        = string
}
variable "check_hauling_scheduler_job_name" {
  description = "Name of the Cloud Scheduler job for Check Hauling Summary"
  type        = string
}
variable "check_hauling_schedule" {
  description = "Cron schedule for the Cloud Scheduler job for Check Hauling Summary"
  type        = string
  default     = "0 * * * *" # every hour
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

variable "pgtobq_sync_cloudfunction_name" {
  description = "Name of the Cloud Function that performs Postgres to Biquery Sync"
  type        = string
}

variable "pgtobq_sync_function_source_dir" {
  description = "Local path to the Postgres to Biquery Sync Cloud Function source code zip files"
  type        = string
}

variable "pgtobq_sync_function_env_vars" {
  description = "Environment variables for Postgres to Biquery Sync Cloud function"
  type        = map(string)
  default     = {}
}

variable "pgtobq_sync_config" {
  description = "Postgres to Biquery Sync Cloud Function configuration parameters"
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

variable "check_hauling_function_name" {
  description = "Name of the check hauling summary Cloud Function"
  type        = string
}

variable "check_hauling_function_source_dir" {
  description = "Local path to the Check Hauling Summary Cloud Function source code zip files"
  type        = string
}

variable "check_hauling_function_env_vars" {
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

variable "docker_repo_name" {
  description = "Name of the Docker repository to push images to"
  type        = string
}

variable "aws_region_v2" {
  description = "AWS region for v2"
  type        = string  
}

variable "aws_region_au" {
  description = "AWS region for au"
  type        = string  
}

variable "aws_region_uk" {
  description = "AWS region for uk"
  type        = string  
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string  
}

variable "domain" {
  description = "Domain name for the application"
  type        = string
  default     = "v2.soilflo.com"
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token for managing DNS records"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for the domain"
  type        = string
}

variable "pods_secondary_ranges" {
  description = "Map of pods secondary IP CIDR ranges per region"
  type        = map(string)
}

variable "services_secondary_ranges" {
  description = "Map of services secondary IP CIDR ranges per region"
  type        = map(string)
}
