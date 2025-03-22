variable "project-name" {
  type        = string
  description = "The name of the project"
  default     = "yantra1"
}

variable "regions" {
  type        = string
  description = "The region of the project"
  default     = "us-central1"
}

variable "network-module" {
  type = object({
    environment_name            = string
    vpc_main                    = string
    subnet                      = string
    subnet_ip_cidr_range        = string
    secondary_pods_ip_range     = string
    secondary_services_ip_range = string
    router                      = string
    nat-name                    = string
  })
}

variable "gcp_credentials_json" {
  type        = string
  description = "GCP service account credentials in JSON format"
}

variable "bucket_name" {
  type        = string
  description = "The name of the existing bucket"
  default     = "yantra1-dev"
}
