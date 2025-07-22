module "apis" {
  source           = "./modules/apis"
  gcp_project_id   = var.gcp_project_id
  depends_on       = [module.iam]
}

module "vpc" {
  source                      = "./modules/vpc"
  vpc_name                    = var.vpc_name
  gcp_region                  = var.gcp_region
  gcp_project_id              = var.gcp_project_id
  regions                     = ["northamerica-northeast1", "europe-west2", "australia-southeast1"]
  subnet_cidrs                = ["10.10.0.0/16", "10.20.0.0/16", "10.30.0.0/16"]
  pods_secondary_ranges       = var.pods_secondary_ranges
  services_secondary_ranges   = var.services_secondary_ranges
  depends_on                  = [module.apis]
}

module "platform_sa" {
  source                = "./modules/service_account"
  gcp_project_id        = var.gcp_project_id
  service_account_name  = "platform-sa"
  display_name          = "Platform Service Account"
}

module "cloudrun_sa" {
  source                = "./modules/service_account"
  gcp_project_id        = var.gcp_project_id
  service_account_name  = "cloudrun-sa"
  display_name          = "Cloud Run Service Account"
}

module "cloudfunction_sa" {
  source                = "./modules/service_account"
  gcp_project_id        = var.gcp_project_id
  service_account_name  = "cloudfunction-sa"
  display_name          = "Cloud Function Service Account"
}

module "iam" {
  source                = "./modules/iam"
  gcp_project_id        = var.gcp_project_id
  platform_sa           = module.platform_sa.sa_email
  cloudrun_sa           = module.cloudrun_sa.sa_email
  cloudfunction_sa      = module.cloudfunction_sa.sa_email
}

module "private_service_access" {
  source                = "./modules/private_service_access"
  gcp_project_id        = var.gcp_project_id
  vpc_self_link         = module.vpc.network_self_link
}

module "v2_stack" {
  source                            = "./env/v2"
  gcp_project_id                    = var.gcp_project_id
  gcp_region                        = var.gcp_region

  aws_region_v2                     = var.aws_region_v2
  environment                       = var.environment 
  domain                            = var.domain

  docker_repo_name                  = var.docker_repo_name

  db_backup_bucket_name             = var.db_backup_bucket_name

  postgres_instance_name            = var.postgres_instance_name
  db_name                           = var.db_name
  db_user                           = var.db_user
  private_network                   = module.vpc.network_self_link

  bigquery_dataset_id               = var.bigquery_dataset_id
  delete_contents_on_destroy        = var.delete_contents_on_destroy

  core_cloudrun_name                = var.core_cloudrun_name
  core_image                        = var.core_image

  html_to_pdf_cloudrun_name         = var.html_to_pdf_cloudrun_name
  html_to_pdf_image                 = var.html_to_pdf_image

  cloudrun_sa                       = module.cloudrun_sa.sa_email
  timeout                           = var.timeout
  limits                            = var.limits
  scaling                           = var.scaling
  startup                           = var.startup
  max_instance_request_concurrency  = var.max_instance_request_concurrency

  db_backup_topic_name              = var.db_backup_topic_name
  pgtobq_sync_topic_name            = var.pgtobq_sync_topic_name
  check_hauling_topic_name          = var.check_hauling_topic_name

  db_backup_scheduler_job_name      = var.db_backup_scheduler_job_name
  db_backup_schedule                = var.db_backup_schedule

  pgtobq_sync_scheduler_job_name    = var.pgtobq_sync_scheduler_job_name
  pgtobq_sync_schedule              = var.pgtobq_sync_schedule

  check_hauling_scheduler_job_name  = var.check_hauling_scheduler_job_name
  check_hauling_schedule            = var.check_hauling_schedule

  time_zone                         = var.time_zone

  function_bucket_name              = var.function_bucket_name
  cloudfunction_sa                  = module.cloudfunction_sa.sa_email
  
  db_backup_cloudfunction_name      = var.db_backup_cloudfunction_name
  db_backup_function_source_dir     = var.db_backup_function_source_dir
  db_backup_config = {
    runtime                         = var.db_backup_config.runtime
    entry_point                     = var.db_backup_config.entry_point
    max_instances                   = var.db_backup_config.max_instances
    min_instances                   = var.db_backup_config.min_instances
    memory                          = var.db_backup_config.memory
    cpu                             = var.db_backup_config.cpu
    timeout                         = var.db_backup_config.timeout
    max_request_concurrency         = var.db_backup_config.max_request_concurrency
  }

  pgtobq_sync_cloudfunction_name    = var.pgtobq_sync_cloudfunction_name
  pgtobq_sync_function_source_dir   = var.pgtobq_sync_function_source_dir
  pgtobq_sync_config = {
    runtime                         = var.pgtobq_sync_config.runtime
    entry_point                     = var.pgtobq_sync_config.entry_point
    max_instances                   = var.pgtobq_sync_config.max_instances
    min_instances                   = var.pgtobq_sync_config.min_instances
    memory                          = var.pgtobq_sync_config.memory
    cpu                             = var.pgtobq_sync_config.cpu
    timeout                         = var.pgtobq_sync_config.timeout
    max_request_concurrency         = var.pgtobq_sync_config.max_request_concurrency
  }

  check_hauling_function_name       = var.check_hauling_function_name
  check_hauling_function_source_dir = var.check_hauling_function_source_dir
  check_hauling_config = {
    runtime                         = var.check_hauling_config.runtime
    entry_point                     = var.check_hauling_config.entry_point
    max_instances                   = var.check_hauling_config.max_instances
    min_instances                   = var.check_hauling_config.min_instances
    memory                          = var.check_hauling_config.memory
    cpu                             = var.check_hauling_config.cpu
    timeout                         = var.check_hauling_config.timeout
    max_request_concurrency         = var.check_hauling_config.max_request_concurrency
  }

  cloudflare_zone_id                = var.cloudflare_zone_id
  platform_sa                       = module.platform_sa.sa_email
  network                           = module.vpc.network_self_link
  subnetwork = module.vpc.subnet_self_links["${var.vpc_name}-${var.gcp_region}-subnet"]

  depends_on                        = [ module.vpc ]
}

