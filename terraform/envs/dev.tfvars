
environment = "dev"
region = "us-central1"
project = "fd-${var.environment}-vpc"

networks = {
        fd-network = {
            subnets = {
                fd-subnetwork = {
                    cidr = "10.128.0.0/20"
                }
            },
            firewall_rules = {
                allow_internal_ingress_public = {
                    name           = "allow-all-ingress-internal-${var.environment}"
                    direction      = "INGRESS"
                    priority       = 65534
                    source_ranges  = ["10.128.0.0/9"]
                    protocol       = "all"
                    ports          = []
                }
            },
            access_connectors = {
                functions = {
                    name_prefix   = "functions"
                    cidr = "10.8.0.0/28",
                    min_throughput = 200,
                    max_throughput = 1000
                },
                infra = {
                    name_prefix   = "fd-infra"
                    cidr = "10.9.0.0/28",
                    min_throughput = 200,
                    max_throughput = 1000
            }
        }
    }