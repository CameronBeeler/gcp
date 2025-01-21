variable environment {
    description = "The environment to deploy resources"
    type        = string
    default     = "dev"
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