resource "google_pubsub_topic" "this" {
  name    = var.topic_name
  project = var.gcp_project_id
}
