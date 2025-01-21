terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.13.0, < 7.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 6.13.0, < 7.0.0"
    }
  }
  required_version = "~> 1.10.4"
}

provider "google" {
  project = var.project_id
  region  = var.region
}
