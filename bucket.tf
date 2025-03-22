data "google_storage_bucket" "existing_bucket" {
  name = var.bucket_name
}

resource "google_storage_bucket" "raw" {
  count = data.google_storage_bucket.existing_bucket ? 0 : 1
  project                     = var.project-name
  name                        = "${var.project-name}-dev"
  force_destroy               = false
  uniform_bucket_level_access = true
  location                    = var.regions
}