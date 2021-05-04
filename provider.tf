terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.66.1"
    }
    
    aws = {
      source = "hashicorp/aws"
      version = "3.38.0"
    }
  }

  required_version = "~> 0.15"
}

provider "google" {
  project = var.gcp_project
  region  = var.gcp_region
  zone    = var.gcp_zone
}

provider "aws" {
  region = var.aws_region
}
