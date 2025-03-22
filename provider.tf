terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.38.0"
    }
  }
}

provider "google" {
  credentials = "${ secrets.GOOGLE_CREDENTIALS }"
  project = var.project-name
  region = "us-central1"
}
