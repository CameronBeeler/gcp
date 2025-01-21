resource "google_compute_global_address" "google_managed_services_range" {
  name          = "google-managed-services-reserved-cidr-${var.environment}"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 20  # Adjust based on your requirements
  network       = google_compute_network.vpc_network.self_link
  description   = "Dynamically allocated IP Range for peer service connection networks."
}
# Network Access channels
resource "google_project_service" "service_networking" {
  project    =  data.google_project.current.project_id
  service    =  "servicenetworking.googleapis.com"

  # Optionally wait for the API activation to propagate
  disable_on_destroy = false
}
resource "google_project_service" "sqladmin_networking" {
  project    =  data.google_project.current.project_id
  service = "sqladmin.googleapis.com"

  # Optionally wait for the API activation to propagate
  disable_on_destroy = false
}
resource "google_service_networking_connection" "private_service_access_service_networking" {
  depends_on               = [google_project_service.service_networking]
  network                  = google_compute_network.vpc_network.self_link
  service                  = "servicenetworking.googleapis.com"
  reserved_peering_ranges  = [google_compute_global_address.google_managed_services_range.name]
}

## NOTE
# Add a connector for serverless access from GCP Public to the VPC.
## NOTE:  Network peering for the two service connections?  SQL at least.
resource "google_vpc_access_connector" "connector_1" {
  name         = "cloud-functions-${var.environment}"
  region       = var.region
  network      = google_compute_network.vpc_network.name
  ip_cidr_range = "10.8.0.0/28" # IP range for connector traffic
}

resource "google_vpc_access_connector" "connector_2" {
  name         = "fd-infra-vpc-connector-${var.environment}"
  region       = var.region
  network      = google_compute_network.vpc_network.name
  ip_cidr_range = "10.9.0.0/28" # IP range for connector traffic
}