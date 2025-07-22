variable "project_id" {
  description = "GCP project ID where GKE cluster will be created"
  type        = string
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}

variable "location" {
  description = "Region or zone for the GKE cluster"
  type        = string
}

variable "network" {
  description = "Name of the VPC network"
  type        = string
}

variable "subnetwork" {
  description = "Name of the subnetwork"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "CIDR block for the master IP range"
  type        = string
}

variable "pods_range" {
  description = "Secondary IP range name for GKE pods"
  type        = string
}

variable "services_range" {
  description = "Secondary IP range name for GKE services"
  type        = string
}

variable "authorized_networks" {
  description = "List of authorized CIDR blocks to access the master"
  type = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = []
}

variable "release_channel" {
  description = "GKE release channel"
  type        = string
  default     = "REGULAR"
}

variable "node_count" {
  description = "Initial number of nodes in the node pool"
  type        = number
  default     = 1
}

variable "min_node_count" {
  description = "Minimum number of nodes for autoscaling"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum number of nodes for autoscaling"
  type        = number
  default     = 3
}

variable "machine_type" {
  description = "Machine type to use for nodes"
  type        = string
  default     = "e2-medium"
}

variable "gke_service_account" {
  description = "Service account to be used by the GKE nodes"
  type        = string
}

variable "node_labels" {
  description = "Labels to add to each node"
  type        = map(string)
  default     = {}
}

variable "node_tags" {
  description = "Network tags to add to each node"
  type        = list(string)
  default     = []
}
