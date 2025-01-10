resource "google_compute_network" "vpc_network" {
  name                    = "vpc-explore-network"
  auto_create_subnetworks = false
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

resource "google_compute_router_nat" "nat_gateway" {
  name                       = "nat-gateway"
  router                     = google_compute_router.nat_router.name
  region                     = google_compute_router.nat_router.region
  nat_ip_allocate_option     = "AUTO_ONLY" # Automatically allocate external IP
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY" # Logs only errors; change to "ALL" for full logs
  }
}
