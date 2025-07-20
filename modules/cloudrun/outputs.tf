output "cloudrun_service_name" {
  description = "Name of the Cloud Run service"
  value       = google_cloud_run_v2_service.cloudrun.name
}

output "cloudrun_uri" {
  description = "URI of the deployed Cloud Run service"
  value       = google_cloud_run_v2_service.cloudrun.uri
}