resource "kubernetes_namespace" "app" {
  metadata {
    name = var.namespace
  }

  depends_on = [
    google_container_node_pool.primary_nodes
  ]
}
