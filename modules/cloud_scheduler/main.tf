resource "google_cloud_scheduler_job" "scheduler_job" {
  name        = var.scheduler_job_name
  project     = var.gcp_project_id
  region      = var.gcp_region
  description = "Triggers daily DB backup"
  schedule    = var.schedule
  time_zone   = var.time_zone

  pubsub_target {
    topic_name = var.pubsub_topic_id
    data       = base64encode(jsonencode({
      project  = var.gcp_project_id,
      instance = var.postgres_instance_name
    }))
  }
}

resource "google_pubsub_topic_iam_member" "function_publish" {
  topic    = var.pubsub_topic_id
  role     = "roles/pubsub.publisher"
  member   = "serviceAccount:${var.cloudfunction_sa}"
}