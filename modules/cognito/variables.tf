variable "aws_region" {
  description = "The GCP region"
  type        = string
}

variable "cloud_run_service_name" {
  type = string
}

variable "cognito_domain_prefix" {
  description = "Unique prefix for Cognito hosted UI domain"
  type        = string
}

variable "cognito_user_pool_arn" {
  type    = string
  default = null
}
