resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "container.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "artifactregistry.googleapis.com"
  ])

  project = var.project_id
  service = each.key

  disable_on_destroy = false
}
