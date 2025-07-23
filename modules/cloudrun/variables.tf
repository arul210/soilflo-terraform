variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_region" {
  description = "GCP region for Cloud Run service"
  type        = string
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

variable "cloudsql_instances" {
  type    = list(string)
  default = []
}

variable "db_user" {
  description = "PostgreSQL username"
  type        = string
}

variable "db_name" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_connection_name" {
  description = "Cloud SQL connection name for Cloud Run"
  type        = string
}

variable "cognito_user_pool_arn" {
  type    = string
  default = null
}
