# ROUTE configurations
resource "google_compute_route" "route_to_internet_igw" {
  name                   = "route-to-internet-${var.environment}"
  description            = "Default route to the Internet."
  network                = google_compute_network.vpc_network.self_link
  dest_range             = "0.0.0.0/0"
  priority               = 1000
  next_hop_gateway       = "default-internet-gateway"
}
