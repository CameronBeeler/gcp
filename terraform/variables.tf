variable environment {
    description = "The environment to deploy resources"
    type        = string
    default     = "staging"
}

variable project_name {
    description = "The project name to deploy resources"
    type        = string
    default = "VPC-Build-project"
}

variable project_id {
    description = "The project ID to deploy resources"
    type        = string
    default    = "sonorous-pact-445620-m2"
} 

variable region {
    description = "The region to deploy resources"
    type        = string
    default     = "us-central1"
} 

variable prefix {
    description = "The prefix to use for all resources"
    type        = string
    default     = "test"
}

variable "region_abbreviations" {
  default = {
    "us-central1"     = "usc1"
    "us-east1"        = "use1"
    "us-east4"        = "use4"
    "us-west1"        = "usw1"
    "us-west2"        = "usw2"
    "us-west3"        = "usw3"
    "us-west4"        = "usw4"
  }
}

variable "firewall_rules" {
  default = {
    allow_icmp_ingress_public = {
      name           = "allow-icmp-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "icmp"
      ports          = []
    }
    allow_internal_ingress_public = {
      name           = "allow-all-internal-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["10.128.0.0/9"]
      protocol       = "all"
      ports          = []
    }
    allow_rdp_ingress_public = {
      name           = "allow-rdp-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "tcp"
      ports          = ["3389"]
    }
    allow_ssh_ingress_public = {
      name           = "allow-ssh-public-${var.environment}"
      direction      = "INGRESS"
      priority       = 65534
      source_ranges  = ["0.0.0.0/0"]
      protocol       = "tcp"
      ports          = ["22"]
    }
  }
}