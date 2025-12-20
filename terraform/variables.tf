variable "project_id" {
  description = "ID del proyecto GCP"
  type        = string
  default     = "devops-reto-tecnico"
}

variable "region" {
  description = "Región de GCP"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Zona de GCP"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "Nombre del cluster GKE"
  type        = string
  default     = "devops-gke"
}

variable "namespace" {
  description = "Namespace de la aplicación"
  type        = string
  default     = "hello-world"
}
