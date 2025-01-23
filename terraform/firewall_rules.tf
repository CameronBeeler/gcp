resource "google_compute_firewall" "firewall_rules" {
  for_each = var.networks["fd-network"].firewall_rules

  name    = "${each.value.name}-${var.environment}"
  network = google_compute_network.vpc_network[each.key].name

  direction = each.value.direction
  priority  = each.value.priority

  source_ranges = each.value.source_ranges

  allow {
    protocol = each.value.protocol
    ports    = each.value.ports
  }
}