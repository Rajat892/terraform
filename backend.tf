terraform {
  backend "gcs" {
    bucket = "${var.project-name}-dev"
    prefix = "dev"
  }
}

# provider "google" {
#   project     = var.project-name
#   region      = var.regions
#   credentials = jsondecode(var.gcp_credentials_json)
# }
