output "network_self_link" {
  description = "Self link of the created VPC network"
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_self_links" {
  description = "Map of subnet names to their self links"
  value = {
    for subnet in google_compute_subnetwork.subnets : subnet.name => subnet.self_link
  }
}
