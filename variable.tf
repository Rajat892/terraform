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

#----------------------------------

variable "gke_cluster_name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "zone" {
  type        = string
  description = "The zone of the GKE cluster"
}

variable "node_version" {
  type        = string
  description = "The version of the node"
}

variable "min_master_version" {
  type        = string
  description = "The minimum version of the master"
}

variable "master-authorized-network-config" {
  type        = list(map(string))
  description = "The master authorized network config"
}

variable "project-id" {
  type        = string
  description = "The project id"
}

variable "gke-cluster-name" {
  type        = string
  description = "The name of the GKE cluster"
}

variable "master_ipv4_cidr_block" {
  type        = string
  description = "The master ipv4 cidr block"
}