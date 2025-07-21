resource "google_storage_bucket" "bucket" {
  name     = "v2-${var.bucket_name}"
  location = var.gcp_region
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
}

resource "google_storage_bucket_iam_member" "cloudfunction_storage_object_admin" {
  bucket      = google_storage_bucket.bucket.name
  role        = "roles/storage.objectAdmin"
  member      = "serviceAccount:${var.cloudfunction_sa}"
  depends_on  = [google_storage_bucket.bucket]
}