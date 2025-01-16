resource "google_compute_firewall" "allow_icmp_ingress_public" {
  name    = "allow-icmp-ingress-public-${var.environment}"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 65534

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "icmp"
  }
}

resource "google_compute_firewall" "allow_internal_ingress_public" {
  name    = "allow-all-ingress-internal-${var.environment}"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 65534

  source_ranges = ["10.128.0.0/9"]

  allow {
    protocol = "all" 
  }
}

resource "google_compute_firewall" "allow_rdp_ingress_public" {
  name    = "allow-rdp-ingress-public-${var.environment}"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 65534

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
}

resource "google_compute_firewall" "allow_ssh_ingress_public" {
  name    = "allow-ssh-ingress-public-${var.environment}"
  network = google_compute_network.vpc_network.name

  direction = "INGRESS"
  priority  = 65534

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
