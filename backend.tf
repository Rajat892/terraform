terraform {
    backend "gcs" { 
      bucket  = "terraform-state-cicdproject"
      prefix  = "dev"
    }
}

provider "google" {
  project = var.project-name
  region = var.regions
}
