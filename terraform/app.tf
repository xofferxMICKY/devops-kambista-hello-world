resource "kubernetes_deployment" "hello_world" {
  metadata {
    name      = "hello-world"
    namespace = kubernetes_namespace.app.metadata[0].name
    labels = {
      app = "hello-world"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "hello-world"
      }
    }

    template {
      metadata {
        labels = {
          app = "hello-world"
        }
      }

      spec {
        container {
          name  = "hello-world"
          image = "us-central1-docker.pkg.dev/devops-reto-tecnico/hello-world/app:latest"

#          args = [
#            "-text=Hello World"
#          ]

          port {
            container_port = 3000
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_namespace.app
  ]
}

resource "kubernetes_service" "hello_world" {
  metadata {
    name      = "hello-world-service"
    namespace = kubernetes_namespace.app.metadata[0].name
  }

  spec {
    selector = {
      app = "hello-world"
    }

    port {
      port        = 80
      target_port = 5678
    }

    type = "LoadBalancer"
  }
}
