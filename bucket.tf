resource "google_storage_bucket" "raw" {
  project                     = var.project-name
  name                        = "${var.project-name}-dev"
  force_destroy               = false
  uniform_bucket_level_access = true
  location                    = var.regions
}
