output "bucket_url" {
  description = "The GCS URL of the database backup bucket"
  value       = "gs://${google_storage_bucket.db_backup_bucket.name}"
}