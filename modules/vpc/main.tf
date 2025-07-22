resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
  project                 = var.gcp_project_id
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnets" {
  for_each        = zipmap(var.regions, var.subnet_cidrs)

  name            = "${var.vpc_name}-${each.key}-subnet"
  ip_cidr_range   = each.value
  region          = each.key
  network         = google_compute_network.vpc_network.id
  project         = var.gcp_project_id

  secondary_ip_range {
    range_name    = "pods-range"
    ip_cidr_range = var.pods_secondary_ranges[each.key]
  }

  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = var.services_secondary_ranges[each.key]
  }
}

resource "google_compute_router" "router" {
  name    = "${var.vpc_name}-router"
  network = google_compute_network.vpc_network.id
  region  = var.gcp_region
  project = var.gcp_project_id
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.vpc_name}-allow-internal"
  network = google_compute_network.vpc_network.name
  project = var.gcp_project_id

  allow {
    protocol = "all"
    ports    = []
  }

  source_ranges = ["10.0.0.0/8"]
  direction     = "INGRESS"
}
