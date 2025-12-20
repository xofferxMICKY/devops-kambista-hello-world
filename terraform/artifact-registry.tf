resource "google_artifact_registry_repository" "docker_repo" {
  location      = var.region
  repository_id = "hello-world"
  format        = "DOCKER"

  description = "Docker repo for hello world app"
}
