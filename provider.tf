terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.38.0"
    }
  }
}

provider "google" {
    credentials = file("yantra1.json")
  project = var.project-name
  region = "us-central1"
}
