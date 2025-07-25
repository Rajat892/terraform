provider "google" {
  credentials = credentials = file("gcp-key.json")
  project     = var.project_id
  region      = var.region_name
  zone        = var.zone
}
