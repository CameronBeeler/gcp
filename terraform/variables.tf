variable environment {
    description = "The environment to deploy resources"
    type        = string
}

variable project_name {
    description = "The project name to deploy resources"
    type        = string
}
variable project_id {
    description = "The project ID to deploy resources"
    type        = string
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