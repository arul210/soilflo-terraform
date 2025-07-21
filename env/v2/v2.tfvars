# GCP Project and Region
gcp_project_id                   = "soilflo-project"
gcp_region                       = "northamerica-northeast1"

# VPC variables
vpc_name                         = "platform-vpc"

# Docker Repo variables
docker_repo_name                 = "core-api-repo"

# GCS bucket variables
db_backup_bucket_name            = "db-backup-bucket"
function_bucket_name             = "srccode-bucket"

# CloudSQL variables
postgres_instance_name           = "postgres-na"
db_name                          = "core_db"
db_user                          = "admin"

# BigQuery variables
bigquery_dataset_id              = "core_dataset"
delete_contents_on_destroy       = false

# Cloud Run variables
cloudrun_name                    = "core-api"
timeout                          = "240s"
image                            = "northamerica-northeast1-docker.pkg.dev/soilflo-project/core-api-repo/placeholder-api:latest"
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

# Pub/Sub variables
topic_name                       = "db-backup-trigger"

# Scheduler variables
scheduler_job_name               = "db-backup-cronjob"
schedule                         = "0 3 * * *" # 3 AM every day
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
check_hauling_summary_function_name       = "check-hauling-summary-cloudfunction"
check_hauling_summary_function_source_dir = "./src/check_hauling_summary"
check_hauling_config = {
  runtime                                 = "python312"
  entry_point                             = "trigger_check_hauling_summary"
  min_instances                           = 0
  max_instances                           = 100
  memory                                  = "32Gi"
  cpu                                     = 8
  timeout                                 = 300
  max_request_concurrency                 = 80
}

# html to pdf 
html_to_pdf_function_name                 = "html-to-pdf-cloudfunction"
html_to_pdf_function_source_dir           = "./src/check_hauling_summary"
html_to_pdf_function_config = {
  runtime                                 = "python312"
  entry_point                             = "trigger_html_to_pdf"
  min_instances                           = 0
  max_instances                           = 100
  memory                                  = "32Gi"
  cpu                                     = 8
  timeout                                 = 300
  max_request_concurrency                 = 80
}