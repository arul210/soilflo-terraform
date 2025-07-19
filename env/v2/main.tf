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