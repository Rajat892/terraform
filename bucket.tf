data "google_storage_bucket" "existing_bucket" {
  name = var.bucket_name
}

resource "google_storage_bucket" "raw" {
  count = length(try(data.google_storage_bucket.existing_bucket.id, [])) == 0
  project                     = var.project-name
  name                        = "${var.project-name}-dev"
  force_destroy               = false
  uniform_bucket_level_access = true
  location                    = var.regions
}

# Output the existing bucket information
output "existing_bucket_info" {
  value = try(data.google_storage_bucket.existing_bucket, null)
}