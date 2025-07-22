module "docker_repo" {
    source                    = "../../modules/artifact_registry"
    gcp_project_id            = var.gcp_project_id
    gcp_region                = var.gcp_region
    docker_repo_name          = var.docker_repo_name
}

module "db_backup_bucket" {
    source                    = "../../modules/gcs_bucket"
    gcp_project_id            = var.gcp_project_id
    bucket_name               = var.db_backup_bucket_name
    gcp_region                = var.gcp_region
    storage_class             = "ARCHIVE"
    versioning                = true
    num_newer_versions        = 3
    cloudfunction_sa          = var.cloudfunction_sa
}

module "function_bucket" {
    source                    = "../../modules/gcs_bucket"
    gcp_project_id            = var.gcp_project_id
    bucket_name               = var.function_bucket_name
    gcp_region                = var.gcp_region
    storage_class             = "STANDARD"
    versioning                = false
    num_newer_versions        = 1
    cloudfunction_sa          = var.cloudfunction_sa
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
    cloudrun_sa                = var.cloudrun_sa
}

module "cloudrun_api" {
    source                            = "../../modules/cloudrun"
    gcp_project_id                    = var.gcp_project_id
    gcp_region                        = var.gcp_region
    cloudrun_name                     = var.core_cloudrun_name
    cloudrun_sa                       = var.cloudrun_sa
    timeout                           = var.timeout
    image                             = var.core_image
    limits                            = var.limits
    scaling                           = var.scaling
    startup                           = var.startup
    max_instance_request_concurrency  = var.max_instance_request_concurrency
    db_user                           = var.db_user
    db_name                           = var.db_name
    postgres_connection_name          = module.cloudsql_postgres.postgres_instance_connection_name
}

module "db_backup_pubsub" {
    source              = "../../modules/pubsub"
    gcp_project_id      = var.gcp_project_id
    topic_name          = var.db_backup_topic_name
}

module "db_backup_scheduler" {
    source                      = "../../modules/cloud_scheduler"
    gcp_project_id              = var.gcp_project_id
    gcp_region                  = var.gcp_region
    scheduler_job_name          = var.db_backup_scheduler_job_name
    schedule                    = var.db_backup_schedule
    time_zone                   = var.time_zone
    pubsub_topic_id             = module.db_backup_pubsub.topic_id
    postgres_instance_name      = var.postgres_instance_name
    cloudfunction_sa            = var.cloudfunction_sa
}

module "db_backup_function" {
    source               = "../../modules/cloudfunction"
    cloudfunction_name   = var.db_backup_cloudfunction_name
    gcp_project_id       = var.gcp_project_id
    gcp_region           = var.gcp_region
    source_dir           = var.db_backup_function_source_dir
    function_bucket_name = module.function_bucket.bucket_name
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

module "pgtobq_sync_pubsub" {
    source              = "../../modules/pubsub"
    gcp_project_id      = var.gcp_project_id
    topic_name          = var.pgtobq_sync_topic_name
}

module "pgtobq_sync_scheduler" {
    source                      = "../../modules/cloud_scheduler"
    gcp_project_id              = var.gcp_project_id
    gcp_region                  = var.gcp_region
    scheduler_job_name          = var.pgtobq_sync_scheduler_job_name
    schedule                    = var.pgtobq_sync_schedule
    time_zone                   = var.time_zone
    pubsub_topic_id             = module.pgtobq_sync_pubsub.topic_id
    postgres_instance_name      = var.postgres_instance_name
    cloudfunction_sa            = var.cloudfunction_sa
}

module "pgtobq_sync_function" {
    source               = "../../modules/cloudfunction"
    cloudfunction_name   = var.pgtobq_sync_cloudfunction_name
    gcp_project_id       = var.gcp_project_id
    gcp_region           = var.gcp_region
    source_dir           = var.pgtobq_sync_function_source_dir
    function_bucket_name = module.function_bucket.bucket_name
    trigger_type         = "pubsub"
    pubsub_topic         = module.pgtobq_sync_pubsub.topic_id
    cloudfunction_sa     = var.cloudfunction_sa
    env_vars             = var.pgtobq_sync_function_env_vars
    config = {
        runtime                 = var.pgtobq_sync_config.runtime
        entry_point             = var.pgtobq_sync_config.entry_point
        max_instances           = var.pgtobq_sync_config.max_instances
        min_instances           = var.pgtobq_sync_config.min_instances
        memory                  = var.pgtobq_sync_config.memory
        cpu                     = var.pgtobq_sync_config.cpu
        timeout                 = var.pgtobq_sync_config.timeout
        max_request_concurrency = var.pgtobq_sync_config.max_request_concurrency
    }
}

module "check_hauling_pubsub" {
    source              = "../../modules/pubsub"
    gcp_project_id      = var.gcp_project_id
    topic_name          = var.check_hauling_topic_name
}

module "check_hauling_scheduler" {
    source                      = "../../modules/cloud_scheduler"
    gcp_project_id              = var.gcp_project_id
    gcp_region                  = var.gcp_region
    scheduler_job_name          = var.check_hauling_scheduler_job_name
    schedule                    = var.check_hauling_schedule
    time_zone                   = var.time_zone
    pubsub_topic_id             = module.check_hauling_pubsub.topic_id
    postgres_instance_name      = var.postgres_instance_name
    cloudfunction_sa            = var.cloudfunction_sa
}

module "check_hauling_function" {
  source               = "../../modules/cloudfunction"
  cloudfunction_name   = var.check_hauling_function_name
  gcp_project_id       = var.gcp_project_id
  gcp_region           = var.gcp_region
  source_dir           = var.check_hauling_function_source_dir
  function_bucket_name = module.function_bucket.bucket_name
  trigger_type         = "http"
  cloudfunction_sa     = var.cloudfunction_sa
  env_vars             = { HAULING_API_URL = module.cloudrun_api.cloudrun_uri }
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

module "html_to_pdf_api" {
    source                            = "../../modules/cloudrun"
    gcp_project_id                    = var.gcp_project_id
    gcp_region                        = var.gcp_region
    cloudrun_name                     = var.html_to_pdf_cloudrun_name
    cloudrun_sa                       = var.cloudrun_sa
    timeout                           = var.timeout
    image                             = var.html_to_pdf_image
    limits                            = var.limits
    scaling                           = var.scaling
    startup                           = var.startup
    max_instance_request_concurrency  = var.max_instance_request_concurrency
    db_user                           = var.db_user
    db_name                           = var.db_name
    postgres_connection_name          = module.cloudsql_postgres.postgres_instance_connection_name
}

module "frontend_static_site" {
    source             = "../../modules/aws"
    environment        = var.environment
    domain             = var.domain
    subdomain          = var.environment
    cloudflare_zone_id = var.cloudflare_zone_id
    providers = {
        aws            = aws.v2
        cloudflare     = cloudflare
    }
}

module "gke" {
  source                   = "../../modules/gke"
  project_id               = var.gcp_project_id
  cluster_name             = "prod-cluster"
  location                 = var.gcp_region
  network                  = var.network
  subnetwork               = var.subnetwork
  master_ipv4_cidr_block   = "172.16.0.0/28"
  pods_range               = "pods-range"
  services_range           = "services-range"

  authorized_networks = [
    {
      cidr_block   = "203.0.113.0/24"
      display_name = "Corp Office"
    },
    {
      cidr_block   = "198.51.100.10/32"
      display_name = "VPN Admin"
    }
  ]

  machine_type        = "e2-standard-4"
  gke_service_account = var.platform_sa
  node_count          = 1
  min_node_count      = 1
  max_node_count      = 3
  node_labels         = { env = "prod" }
  node_tags           = ["gke-prod"]
}

module "auth" {
  source                    = "./modules/cognito_cloudrun_auth"
  cloud_run_service_name    = module.cloudrun_api.cloudrun_service_name
  cognito_domain_prefix     = "myapp-auth-domain"
}
