locals {
  firewall_rules = {
    allow_icmp_ingress_public = {
      name           = "allow-icmp-ingress-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "icmp"
      ports          = []
    }
    allow_internal_ingress_public = {
      name           = "allow-all-ingress-internal-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["10.128.0.0/9"]
      protocol       = "all"
      ports          = []
    }
    allow_rdp_ingress_public = {
      name           = "allow-rdp-ingress-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "tcp"
      ports          = ["3389"]
    }
    allow_ssh_ingress_public = {
      name           = "allow-ssh-ingress-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "tcp"
      ports          = ["22"]
    }
  }
}

resource "google_compute_firewall" "firewall_rules" {
  for_each = local.firewall_rules

  name    = each.value.name
  network = google_compute_network.vpc_network.name

  direction = each.value.direction
  priority  = each.value.priority

  source_ranges = each.value.source_ranges

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}