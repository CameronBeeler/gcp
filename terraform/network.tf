resource "google_compute_network" "vpc_network" {
  for_each = var.networks["fd-network"].vpc_network

  name                    = "${each.value.name}-${var.environment}"
  auto_create_subnetworks = false
}

# NAT gateway
resource "google_compute_router" "nat_router_us_central1" {
  for_each = google_compute_network.vpc

  name    = "nat-router-key${each.key}-${var.environment}"
  region  = "us-central1" # Specify the region of the subnets requiring NAT
  network = each.value.self_link
}
resource "google_compute_router_nat" "nat_gateway" {
  for_each = google_compute_network.vpc_network

  name                               = "nat-gateway-key${each.key}-${var.environment}"
  router                             = google_compute_router.nat_router_us_central1[each.key].name
  region                             = google_compute_router.nat_router_us_central1[each.key].region
  nat_ip_allocate_option             = "AUTO_ONLY" # Automatically allocate external IP
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = true
    filter = "ERRORS_ONLY" # Logs only errors; change to "ALL" for full logs
  }
}
# Subnet configurations
resource "google_compute_subnetwork" "us_central1_subnet" {
  for_each                 = var.networks["fd-network"].subnets

  name                     = "${each.value.name}-${var.environment}"
  ip_cidr_range            = each.value.ip_cidr_range
  region                   = each.value.region
  network                  = google_compute_network.vpc_network[each.key].id
  private_ip_google_access = each.value.private_ip_google_access
}