variable environment {
    description = "The environment to deploy resources"
    type        = string
    default     = "staging"
}


variable "networks" {
  description = "complex resource data elements"
  type = map(object({
    vpc_network        = map(object({
        name                     = "fd-network"
        auto_create_subnetworks  = false 
    }))
    subnets            = map(object({
      name                     = string
      ip_cidr_range            = string
      region                   = string
      private_ip_google_access = bool
    }))
    firewall_rules     = map(object({
      name          = string
      direction     = string
      priority      = number
      source_ranges = list(string)
      protocol      = string
      ports         = list(string)
    }))
    access_connectors  = map(object({
      name_prefix    = string
      ip_cidr_range  = string
      region         = string
      min_throughput = number
      max_throughput = number
    }))
  }))
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