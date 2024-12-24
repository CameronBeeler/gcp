provider "google" {
  project = "sonorous-pact-445620-m2"
  region  = "us-central1"
}

resource "google_compute_network" "my_vpc" {
  name                    = "my-vpc-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my_subnet" {
  name          = "my-vpc-subnet"
  ip_cidr_range = "10.0.1.0/24"
  network       = google_compute_network.my_vpc.self_link
  region        = "us-central1"
}
