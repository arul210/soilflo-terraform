resource "google_cloud_run_v2_service" "cloudrun" {
  name          = "v2-${var.cloudrun_name}"
  location      = var.gcp_region
  project       = var.gcp_project_id
  ingress       = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  launch_stage  = "GA" 

  template {
    timeout = var.timeout
    containers {
      image = var.image
      ports {
        container_port = var.startup.port
      }
      startup_probe {
        initial_delay_seconds = var.startup.initial_delay_seconds
        timeout_seconds       = var.startup.timeout_seconds
        failure_threshold     = var.startup.failure_threshold
        tcp_socket {
          port = var.startup.port
        }
      }
      resources {
        cpu_idle          = false
        startup_cpu_boost = true
        limits = {
          "cpu"    = var.limits.cpu
          "memory" = var.limits.memory
        }
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = var.cloudsql_instances
      }
    }

    service_account = var.cloudrun_sa
    scaling {
      min_instance_count = var.scaling.min_instances
      max_instance_count = var.scaling.max_instances
    }
    max_instance_request_concurrency = var.max_instance_request_concurrency
  }
}