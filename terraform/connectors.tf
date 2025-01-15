resource "google_compute_global_address" "google_managed_services_range" {
  name          = "google-managed-services-reserved-cidr-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20  # Adjust based on your requirements
  network       = google_compute_network.custom_vpc.self_link
  description   = "Dynamically allocated IP Range for peer service connection networks."
}
# Network Access channels
resource "google_service_networking_connection" "private_service_access" {
  network                = google_compute_network.custom_vpc.self_link
  service                = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.google_managed_services_range.name]
}