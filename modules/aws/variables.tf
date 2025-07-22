variable "environment" {
  type = string
}

variable "domain" {
  type = string
}

variable "subdomain" {
  description = "Subdomain used for this site (e.g., www)"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for your domain"
  type        = string
}