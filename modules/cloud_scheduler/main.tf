resource "google_cloud_scheduler_job" "cron_job" {
  name        = var.scheduler_job_name
  project     = var.gcp_project_id
  region      = var.gcp_region
  description = "Triggers daily DB backup"
  schedule    = var.schedule
  time_zone   = var.time_zone

  pubsub_target {
    topic_name = var.pubsub_topic_id
    data       = base64encode(var.message_payload)
  }
}
