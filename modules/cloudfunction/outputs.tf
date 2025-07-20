output "cloudfunction_name" {
  description = "Name of the Cloud Function"
  value       = google_cloudfunctions2_function.cloudfunction.name
}

output "cloudfunction_url" {
  description = "The URL for the deployed Cloud Function (HTTP trigger only)"
  value       = try(google_cloudfunctions2_function.cloudfunction.service_config[0].uri, null)
}