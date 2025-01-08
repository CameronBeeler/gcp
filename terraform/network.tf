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

resource "google_compute_firewall" "allow_https_ingress_public" {
  name    = "allow-https-ingress"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 1000

  target_tags = ["https-ingress"]

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "allow_http_ingress_public" {
  name    = "allow-http-ingress"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 1000

  target_tags = ["http-ingress"]

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}

resource "google_compute_firewall" "allow_tcp_vpc" {
  name    = "allow-tcp-vpc"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 1000

  source_tags = ["public-resource-tag"]  # Resources with this tag are the source
  target_tags = ["private-resource-tag"] # Resources with this tag are the target

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]  # Open all TCP ports
  }
}

resource "google_compute_firewall" "allow_icmp_all" {
  name    = "allow-icmp-all"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 65535

  source_ranges = ["0.0.0.0/0"]  # all from the internet
  target_tags = ["public-resource-tag"] # Resources with this tag are the target

  allow {
    protocol = "icmp"
  }
}