resource "google_storage_bucket" "raw" {
  project = var.project-name
  name = "${var.project-name}-dev"
  force_destroy = false
  uniform_bucket_level_access = true
  location = var.regions
}

provider "google" {
  credentials = jsondecode(var.gcp_credentials_json)
  project     = var.project-name
  region      = var.regions
}