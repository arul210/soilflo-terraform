data "google_secret_manager_secret_version" "db_root_password" {
  secret  = "postgresdb-root-password"
  version = "latest"
}

resource "google_sql_database_instance" "postgres_instance" {
  name             = var.postgres_instance_name
  database_version = "POSTGRES_15"
  region           = var.gcp_region
  project          = var.gcp_project_id

  settings {
    tier                        = "db-custom-4-15360" # 4 vCPU, 15 GB RAM
    availability_type           = "ZONAL"
    deletion_protection_enabled = true

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
    }

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.private_network
      ssl_mode        = "ENCRYPTED_ONLY"
    }

    maintenance_window {
      day          = 7  # Sunday
      hour         = 3  # 3 AM UTC
      update_track = "stable"
    }

    disk_size          = 50
    disk_type          = "PD_SSD"
    activation_policy  = "ALWAYS"
    # Data caching is not supported. It is only applicable for enterprise plus edition.
    # data_cache_config {
    #   data_cache_enabled = true
    # }
  }

  root_password = data.google_secret_manager_secret_version.db_root_password.secret_data
}

resource "google_sql_database" "postgres_db" {
  name     = var.db_name
  instance = google_sql_database_instance.postgres_instance.name
  project  = var.gcp_project_id
}

resource "google_sql_user" "postgres_user" {
  name     = var.db_user
  instance = google_sql_database_instance.postgres_instance.name
  password = data.google_secret_manager_secret_version.db_root_password.secret_data
  project  = var.gcp_project_id
}
