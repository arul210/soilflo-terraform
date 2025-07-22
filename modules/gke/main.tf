resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.location
  network            = var.network
  subnetwork         = var.subnetwork
  remove_default_node_pool = true
  initial_node_count = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range
    services_secondary_range_name = var.services_range
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
        for_each = var.authorized_networks
        content {
        cidr_block   = cidr_blocks.value.cidr_block
        display_name = cidr_blocks.value.display_name
        }
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  release_channel {
    channel = var.release_channel
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-nodes"
  cluster    = google_container_cluster.primary.name
  location   = var.location
  node_count = var.node_count

  node_config {
    machine_type    = var.machine_type
    service_account = var.gke_service_account
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
    workload_metadata_config {
      mode = "GKE_METADATA"
    }
    labels = var.node_labels
    tags   = var.node_tags
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}
