terraform {
    backend "gcs" { 
      bucket  = "terraform-state-cicdproject"
      prefix  = "dev"
      depends_on = [google_storage_bucket.dev]
    }
}

provider "google" {
  project = var.project-name
  region = var.regions
  credentials = jsondecode(var.gcp_credentials_json)
}
