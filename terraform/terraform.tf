terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
  backend "gcs" {
    bucket = "terraform-hcl-gcp-githubactions-state"
    prefix = "terraform/hcl-camstest-sonorous-pact-445620-m2"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
