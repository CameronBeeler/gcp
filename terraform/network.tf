resource "google_compute_network" "vpc_network" {
  name                    = "vpc-explore-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_us_west1_subnet" {
  name          = "private-us-west1"
  ip_cidr_range = "10.0.0.0/20"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_us_west1_subnet" {
  name          = "public-us-west1"
  ip_cidr_range = "10.0.16.0/20"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "private_us_south1_subnet" {
  name          = "private-us-south1"
  ip_cidr_range = "10.0.32.0/20"
  region        = "us-south1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_us_south1_subnet" {
  name          = "public-us-south1"
  ip_cidr_range = "10.0.48.0/20"
  region        = "us-south1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "private_us_central1_subnet" {
  name          = "private-us-central1"
  ip_cidr_range = "10.0.64.0/20"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_us_central1_subnet" {
  name          = "public-us-central1"
  ip_cidr_range = "10.0.80.0/20"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "private_us_east4_subnet" {
  name          = "private-us-east4"
  ip_cidr_range = "10.0.96.0/20"
  region        = "us-east4"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_us_east4_subnet" {
  name          = "public-us-east4"
  ip_cidr_range = "10.0.112.0/20"
  region        = "us-east4"
  network       = google_compute_network.vpc_network.id
}