resource "google_compute_network" "vpc_network" {
  name                    = "vpc-explore-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "subnet-explore"
  ip_cidr_range = "10.0.0.0/20"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}