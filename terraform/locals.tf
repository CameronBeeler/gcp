locals{
  # Define the abbreviations for the regions
  region_abbreviations = {
    "us-central1"     = "usc1"
    "us-east1"        = "use1"
    "us-east4"        = "use4"
    "us-west1"        = "usw1"
    "us-west2"        = "usw2"
    "us-west3"        = "usw3"
    "us-west4"        = "usw4"
  }[var.region]

  firewall_rules = {
    allow_internal_ingress_public = {
      name           = "allow-all-ingress-internal-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["10.128.0.0/9"]
      protocol       = "all"
      ports          = []
    }
  }

  vpc_access_connectors = {
    functions = {
      name_prefix   = "functions"
      ip_cidr_range = "10.8.0.0/28"
      min_throughput = 200
      max_throughput = 400
    }
    infra = {
      name_prefix   = "fd-infra"
      ip_cidr_range = "10.9.0.0/28"
      min_throughput = 200
      max_throughput = 400
    }
  }
}