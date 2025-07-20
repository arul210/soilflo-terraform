resource "google_storage_bucket_object" "source_code" {
  name   = "v2-${var.cloudfunction_name}.zip"
  bucket = var.function_bucket_name
  source = "${var.source_dir}/v2-${var.cloudfunction_name}.zip"
}

resource "google_cloudfunctions2_function" "cloudfunction" {
  name        = "v2-${var.cloudfunction_name}"
  location    = var.gcp_region
  project     = var.gcp_project_id

  build_config {
    runtime               = var.config.runtime
    entry_point           = var.config.entry_point
    source {
      storage_source {
        bucket = var.function_bucket_name
        object = google_storage_bucket_object.source_code.name
      }
    }
  }

  service_config {
    max_instance_count               = var.config.max_instances
    min_instance_count               = var.config.min_instances
    available_memory                 = var.config.memory
    available_cpu                    = var.config.cpu
    timeout_seconds                  = var.config.timeout
    max_instance_request_concurrency = var.config.max_request_concurrency
    environment_variables            = var.env_vars
    ingress_settings                 = "ALLOW_INTERNAL_ONLY"
    all_traffic_on_latest_revision   = true
    service_account_email            = var.cloudfunction_sa
  }

  dynamic "event_trigger" {
    for_each = var.trigger_type == "pubsub" ? [1] : []
    content {
      trigger_region = var.gcp_region
      event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
      pubsub_topic   = var.pubsub_topic
      retry_policy   = "RETRY_POLICY_RETRY"
    }
  }

  dynamic "event_trigger" {
    for_each = var.trigger_type == "http" ? [1] : []
    content {
      # Placeholder to support HTTP triggers; no fields required for HTTP
    }
  }

  lifecycle {
    replace_triggered_by = [
      google_storage_bucket_object.source_code
    ]
  }
}