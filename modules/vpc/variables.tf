variable "vpc_name" {
  description = "Name of the VPC network"
  type        = string
}

variable "gcp_region" {
  description = "Primary region for VPC-wide resources like router"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "regions" {
  description = "List of regions to create subnets in"
  type        = list(string)
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for each subnet (same order as regions)"
  type        = list(string)
}

variable "pods_secondary_ranges" {
  type = map(string)
  description = "Secondary IP ranges for pods per region"
}

variable "services_secondary_ranges" {
  type = map(string)
  description = "Secondary IP ranges for services per region"
}
