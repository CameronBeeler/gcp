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
  network                  = google_compute_network.vpc_network.self_link
  service                  = "servicenetworking.googleapis.com"
  reserved_peering_ranges  = [google_compute_global_address.google_managed_services_range.name]

  depends_on               = [google_project_service.service_networking]
}

resource "google_project_service" "serverless_vpc_access" {
  project = var.project_id
  service = "vpcaccess.googleapis.com"

  # Optional: Prevent the service from being disabled during `terraform destroy`
  disable_on_destroy = false
}

## NOTE
# Add a connector for serverless access from GCP Public to the VPC.
## NOTE:  Network peering for the two service connections?  SQL at least.
resource "google_vpc_access_connector" "functions_connector" {
  name         = "functions-${var.region_abbreviations["var.region"]}-${substr(var.environment, 0,8)}"
  region       = var.region
  network      = google_compute_network.vpc_network.name
  ip_cidr_range = "10.8.0.0/28" # IP range for connector traffic

  depends_on = [google_project_service.serverless_vpc_access]
}

resource "google_vpc_access_connector" "infra_connector" {
  name         = "vpc-infra-${var.region_abbreviations["${var.region}"]}-${substr(var.environment, 0,8)}"
  region       = var.region
  network      = google_compute_network.vpc_network.name
  ip_cidr_range = "10.9.0.0/28" # IP range for connector traffic

  depends_on = [google_project_service.serverless_vpc_access]
}