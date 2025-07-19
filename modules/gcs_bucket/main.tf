resource "google_storage_bucket" "db_backup_bucket" {
  name     = var.db_backup_bucket_name
  location = var.db_backup_bucket_location
  project  = var.gcp_project_id

  storage_class = var.storage_class

  versioning {
    enabled = var.versioning
  }

  uniform_bucket_level_access = true

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      num_newer_versions = var.num_newer_versions
    }
  }

  labels = {
    env         = "v2"
    type        = "backup"
    managed_by  = "terraform"
  }
}
