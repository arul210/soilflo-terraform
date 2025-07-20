module "gcs_db_backup" {
    source                    = "../../modules/gcs_bucket"
    gcp_project_id            = var.gcp_project_id
    db_backup_bucket_name     = var.db_backup_bucket_name
    db_backup_bucket_location = var.db_backup_bucket_location
    storage_class             = "ARCHIVE"
    versioning                = true
    num_newer_versions        = 3
}

module "cloudsql_postgres" {
    source                    = "../../modules/cloudsql"
    gcp_project_id            = var.gcp_project_id
    gcp_region                = var.gcp_region
    postgres_instance_name    = var.postgres_instance_name
    db_name                   = var.db_name
    db_user                   = var.db_user
    private_network           = var.private_network
}

module "bigquery" {
    source                     = "../../modules/bigquery"
    gcp_project_id             = var.gcp_project_id
    bigquery_dataset_id        = var.bigquery_dataset_id
    gcp_region                 = var.gcp_region
    delete_contents_on_destroy = var.delete_contents_on_destroy
}

module "cloudrun_api" {
    source                            = "../../modules/cloudrun"
    gcp_project_id                    = var.gcp_project_id
    gcp_region                        = var.gcp_region
    cloudrun_name                     = var.cloudrun_name
    cloudrun_sa                       = var.cloudrun_sa
    timeout                           = var.timeout
    image                             = var.image
    limits                            = var.limits
    scaling                           = var.scaling
    startup                           = var.startup
    max_instance_request_concurrency  = var.max_instance_request_concurrency
    cloudsql_instances                = [module.cloudsql_postgres.postgres_instance_connection_name]
}

module "db_backup_pubsub" {
    source              = "../../modules/pubsub"
    gcp_project_id      = var.gcp_project_id
    topic_name          = var.topic_name
}

module "db_backup_scheduler" {
    source              = "../../modules/cloud_scheduler"
    gcp_project_id      = var.gcp_project_id
    gcp_region          = var.gcp_region
    scheduler_job_name  = var.scheduler_job_name
    schedule            = var.schedule
    time_zone           = var.time_zone
    pubsub_topic_id     = module.db_backup_pubsub.topic_id
}

module "db_backup_function" {
    source               = "../../modules/cloudfunction"
    cloudfunction_name   = var.db_backup_cloudfunction_name
    gcp_project_id       = var.gcp_project_id
    gcp_region           = var.gcp_region
    source_dir           = var.db_backup_function_source_dir
    function_bucket_name = var.function_bucket_name
    trigger_type         = "pubsub"
    pubsub_topic         = module.db_backup_pubsub.topic_id
    cloudfunction_sa     = var.cloudfunction_sa
    env_vars             = var.db_backup_function_env_vars
    config = {
        runtime                 = var.db_backup_config.runtime
        entry_point             = var.db_backup_config.entry_point
        max_instances           = var.db_backup_config.max_instances
        min_instances           = var.db_backup_config.min_instances
        memory                  = var.db_backup_config.memory
        cpu                     = var.db_backup_config.cpu
        timeout                 = var.db_backup_config.timeout
        max_request_concurrency = var.db_backup_config.max_request_concurrency
    }
}

module "check_hauling_summary_function" {
  source               = "../../modules/cloudfunction"
  cloudfunction_name   = var.check_hauling_summary_function_name
  gcp_project_id       = var.gcp_project_id
  gcp_region           = var.gcp_region
  source_dir           = var.check_hauling_summary_function_source_dir
  function_bucket_name = var.function_bucket_name
  trigger_type         = "http"
  cloudfunction_sa     = var.cloudfunction_sa
  env_vars             = var.check_hauling_summary_function_env_vars
  config = {
    runtime                  = var.check_hauling_config.runtime
    entry_point              = var.check_hauling_config.entry_point
    max_instances            = var.check_hauling_config.max_instances
    min_instances            = var.check_hauling_config.min_instances
    memory                   = var.check_hauling_config.memory
    cpu                      = var.check_hauling_config.cpu
    timeout                  = var.check_hauling_config.timeout
    max_request_concurrency  = var.check_hauling_config.max_request_concurrency
  }
}

module "html_to_pdf_function" {
  source               = "../../modules/cloudfunction"
  cloudfunction_name   = var.html_to_pdf_function_name
  gcp_project_id       = var.gcp_project_id
  gcp_region           = var.gcp_region
  source_dir           = var.html_to_pdf_function_source_dir
  function_bucket_name = var.function_bucket_name
  trigger_type         = "http"
  cloudfunction_sa     = var.cloudfunction_sa
  env_vars             = var.html_to_pdf_function_env_vars
  config = {
    runtime                  = var.html_to_pdf_function_config.runtime
    entry_point              = var.html_to_pdf_function_config.entry_point
    max_instances            = var.html_to_pdf_function_config.max_instances
    min_instances            = var.html_to_pdf_function_config.min_instances
    memory                   = var.html_to_pdf_function_config.memory
    cpu                      = var.html_to_pdf_function_config.cpu
    timeout                  = var.html_to_pdf_function_config.timeout
    max_request_concurrency  = var.html_to_pdf_function_config.max_request_concurrency
  }
}
