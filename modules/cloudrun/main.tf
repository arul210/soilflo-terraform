resource "google_cloud_run_v2_service" "cloudrun" {
  name         = "v2-${var.cloudrun_name}"
  location     = var.gcp_region
  project      = var.gcp_project_id
  ingress      = "INGRESS_TRAFFIC_INTERNAL_ONLY"
  launch_stage = "GA"

  template {
    timeout = var.timeout

    containers {
      image = var.image

      # ENV VARS
      env {
        name  = "INSTANCE_CONNECTION_NAME"
        value = var.postgres_connection_name
      }
      env {
        name  = "DB_USER"
        value = var.db_user
      }
      env {
        name  = "DB_NAME"
        value = var.db_name
      }
      env {
        name = "DB_PASS"
        value_source {
          secret_key_ref {
            secret  = "postgresdb-root-password"
            version = "latest"
          }
        }
      }

      # Cloud SQL volume mount
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }

      # Port config
      ports {
        container_port = var.startup.port
      }

      # Startup probe
      startup_probe {
        initial_delay_seconds = var.startup.initial_delay_seconds
        timeout_seconds       = var.startup.timeout_seconds
        failure_threshold     = var.startup.failure_threshold
        tcp_socket {
          port = var.startup.port
        }
      }

      # Resources
      resources {
        cpu_idle          = false
        startup_cpu_boost = true
        limits = {
          "cpu"    = var.limits.cpu
          "memory" = var.limits.memory
        }
      }
    }

    # Cloud SQL Instance attachment
    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [var.postgres_connection_name]
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
