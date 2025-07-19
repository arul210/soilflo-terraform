output "enabled_apis" {
  description = "List of APIs enabled on the project"
  value       = keys(google_project_service.apis)
}
