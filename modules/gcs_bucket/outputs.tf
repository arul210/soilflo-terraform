output "bucket_url" {
  description = "The GCS URL of the database backup bucket"
  value       = "gs://${google_storage_bucket.bucket.name}"
}

output "bucket_name" {
  description = "The Name of the database backup bucket"
  value       = google_storage_bucket.bucket.name
}