resource "google_compute_global_address" "google_managed_services_range" {
  name          = "google-managed-services-reserved-cidr-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20  # Adjust based on your requirements
  network       = google_compute_network.vpc_network.self_link
  description   = "Dynamically allocated IP Range for peer service connection networks."
}

# Network Access channels
resource "google_service_networking_connection" "private_service_access_service_networking" {
  network                  = google_compute_network.vpc_network.self_link
  service                  = "servicenetworking.googleapis.com"
  reserved_peering_ranges  = [google_compute_global_address.google_managed_services_range.name]
}

# Add a connector for serverless access from GCP Public to the VPC.
## NOTE:  Network peering for the two service connections?  SQL at least.
resource "google_vpc_access_connector" "connectors" {
  for_each      = networks.fd_network.access_connectors
  name          = "${each.value.name_prefix}-${local.region_abbreviations}-${substr(var.environment, 0, 8)}" # name is <= 23 bytes max
  region        = var.region
  network       = google_compute_network.vpc_network.name
  ip_cidr_range = each.value.ip_cidr_range
  min_throughput = each.value.min_throughput
  max_throughput = each.value.max_throughput
}