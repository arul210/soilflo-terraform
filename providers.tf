terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "aws" {
  alias = "v2"
  region = var.aws_region_v2
}

provider "aws" {
  alias = "au"
  region = var.aws_region_au
}

provider "aws" {
  alias = "uk"
  region = var.aws_region_uk
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
