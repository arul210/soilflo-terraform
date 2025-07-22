# GCP Project and Region
gcp_project_id                   = "soilflo-terraform"
gcp_region                       = "europe-west2"

# AWS Region
aws_region_v2                    = "ca-central-1"
aws_region_au                    = "ap-southeast-2"
aws_region_uk                    = "uk-west-2"
environment                      = "uk"
domain                           = "soilflo.com"

# Cloudflare API Token
cloudflare_api_token             = "your-cloudflare-api-token"
cloudflare_zone_id               = "your-cloudflare-zone-id"

# VPC variables
vpc_name                         = "platform-vpc"
pods_secondary_ranges = {
  "northamerica-northeast1"      = "10.40.0.0/20"
  "europe-west2"                 = "10.50.0.0/20"
  "australia-southeast1"         = "10.60.0.0/20"
}

services_secondary_ranges = {
  "northamerica-northeast1"      = "10.41.0.0/24"
  "europe-west2"                 = "10.51.0.0/24"
  "australia-southeast1"         = "10.61.0.0/24"
}

# Docker Repo variables
docker_repo_name                 = "core-api-repo"

# GCS bucket variables
db_backup_bucket_name            = "db-backup-bucket-soilflo"
function_bucket_name             = "srccode-bucket-soilflo"

# CloudSQL variables
postgres_instance_name           = "postgres-na"
db_name                          = "core_db"
db_user                          = "admin"

# Cloud Run variables
timeout                          = "240s"
max_instance_request_concurrency = 80
limits = {
  cpu                            = "8.0"
  memory                         = "32Gi"
}
scaling = {
  min_instances                  = 1
  max_instances                  = 10
}
startup = {
  port                           = 8080
  initial_delay_seconds          = 0
  timeout_seconds                = 240
  failure_threshold              = 3
}

# core-api
core_cloudrun_name               = "core-api"
core_image                       = "europe-west2-docker.pkg.dev/soilflo-terraform/core-api-repo/placeholder-api:latest"

# html to pdf
html_to_pdf_cloudrun_name        = "html-to-pdf-api"
html_to_pdf_image                = "europe-west2-docker.pkg.dev/soilflo-terraform/core-api-repo/html-to-pdf:latest"

# Pub/Sub variables
db_backup_topic_name             = "db-backup-trigger"
check_hauling_topic_name         = "check-hauling-trigger"

# Scheduler variables
db_backup_scheduler_job_name     = "db-backup-cronjob"
db_backup_schedule               = "0 3 * * *" # 3 AM every day

check_hauling_scheduler_job_name = "check-hauling-cronjob"
check_hauling_schedule           = "0 * * * *" # every hour

time_zone                        = "America/Toronto"

# Cloud Function variables
# DB Backup
db_backup_cloudfunction_name     = "db-backup-cloudfunction"
db_backup_function_source_dir    = "./src/db_backup"
db_backup_config = {
  runtime                        = "python312"
  entry_point                    = "trigger_db_backup"
  min_instances                  = 0
  max_instances                  = 1
  memory                         = "32Gi"
  cpu                            = 8
  timeout                        = 300
  max_request_concurrency        = 80
}      

# Check Hauling Summary 
check_hauling_function_name       = "check-hauling-cloudfunction"
check_hauling_function_source_dir = "./src/check_hauling_summary"
check_hauling_config = {
  runtime                         = "python312"
  entry_point                     = "trigger_check_hauling_summary"
  min_instances                   = 0
  max_instances                   = 1
  memory                          = "32Gi"
  cpu                             = 8
  timeout                         = 300
  max_request_concurrency         = 80
}