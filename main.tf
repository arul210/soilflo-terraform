module "vpc" {
  source           = "./modules/vpc"
  vpc_name         = var.vpc_name
  gcp_region       = var.gcp_region
  gcp_project_id   = var.gcp_project_id
  regions          = ["northamerica-northeast2", "europe-west2", "australia-southeast1"]
  subnet_cidrs     = ["10.10.0.0/16", "10.20.0.0/16", "10.30.0.0/16"]
  depends_on       = [module.apis]
}

module "apis" {
  source           = "./modules/apis"
  gcp_project_id   = var.gcp_project_id
  depends_on       = [module.iam]
}

module "service_account" {
  source                = "./modules/service_account"
  gcp_project_id        = var.gcp_project_id
  service_account_name  = "platform-sa"
  display_name          = "Platform Service Account"
}

module "iam" {
  source                = "./modules/iam"
  gcp_project_id        = var.gcp_project_id
  platform_sa_email     = module.service_account.platform_sa_email
}

module "v2_stack" {
  source                    = "./env/v2"
  gcp_project_id            = var.gcp_project_id
  gcp_region                = var.gcp_region

  db_backup_bucket_name     = var.db_backup_bucket_name
  db_backup_bucket_location = var.db_backup_bucket_location

  postgres_instance_name    = var.postgres_instance_name
  db_name                   = var.db_name
  db_user                   = var.db_user
  private_network           = module.vpc.network_self_link
}

