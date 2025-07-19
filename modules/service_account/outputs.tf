output "platform_sa_email" {
  description = "Email of the created service account"
  value = google_service_account.platform_sa.email
}