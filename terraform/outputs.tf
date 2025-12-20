output "cluster_name" {
  value = google_container_cluster.gke.name
}

output "cluster_endpoint" {
  value = google_container_cluster.gke.endpoint
}

output "namespace" {
  value = kubernetes_namespace.app.metadata[0].name
}

output "artifact_registry_repo" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}
