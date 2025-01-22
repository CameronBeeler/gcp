locals {
  firewall_rules = {
    allow_internal_ingress_public = {
      name           = "allow-all-internal-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["10.128.0.0/9"]
      protocol       = "all"
      ports          = []
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