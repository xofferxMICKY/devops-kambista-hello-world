## Levantar infraestructura y aplicación
```bash
cd terraform
terraform init
terraform apply
```

## Acceso a la app
Ejecutar el comando en consola de GCP
```bash
kubectl get svc -n hello-world
``` 
En el navegador colocar: http://<EXTERNAL-IP>


## Cómo ejecutar el pipeline
El pipeline de CI/CD está implementado con GitHub Actions y se ejecuta automáticamente.
### Ejecución:
Cada push a la rama main dispara el pipeline.
No se requiere ejecución manual.


## Decisiones técnicas y justificaciones
### Seguridad
Se creó un Service Account dedicado para el pipeline, siguiendo el principio de menor privilegio.
Roles:
roles/artifactregistry.writer     # Publicar imágenes Docker
roles/container.developer         # Desplegar recursos en GKE
roles/container.clusterViewer     # Consultar estado del cluster

El proyecto tiene habilitada la política iam.disableServiceAccountKeyCreation, lo que impide el uso de claves estáticas.
Como solución segura, se implementó Workload Identity Federation entre GitHub Actions y GCP.
Esto permite autenticación sin claves, restringida únicamente al repositorio autorizado


## Monitoreo y Trazabilidad (Logs)
El microservicio emite logs estructurados en formato JSON por cada request HTTP,
incluyendo información como método y URL.

Estos logs se envían automáticamente a Cloud Logging (Stackdriver) mediante GKE,
permitiendo visualizar y rastrear el comportamiento del servicio.

### Para acceder a los logs:
1. Ir a Operations → Logging → Logs Explorer
2. Relaizar los siguientes filtros:
    Tipo de recurso: Contenedor de Kubernetes
    Cluster: devops-gke
    Namespace: hello-world
    Container: hello-world
3. Hacer clic en APLICAR



# CONFIGURACION MULTI-ENTORNO
## Adaptación de la infraestructura
En el modulo de terraform/variables.tf
Agregar una variable "environment" en Terraform
Archivos de variables por entorno (dev.tfvars, staging.tfvars, prod.tfvars)

## reemplzar
Valores hardcodeados (nombres de cluster, recursos, tamaños) por variables
### Ejemplo conceptual
variable "environment" {
  description = "Nombre del entorno"
}

resource "google_container_cluster" "gke" {
  name = "gke-${var.environment}"
}

### Ejecucion por entorno
```bash
terraform apply -var-file=dev.tfvars
terraform apply -var-file=prod.tfvars
```

## Adaptación del pipeline CI/CD
Se tendrá que agregar una variable "ENVIROMENT" en el workflow de GITHUB ACTIONS
develop → ENVIRONMENT=dev
main → ENVIRONMENT=prod

## Manejo de secretos y permisos
Se agregaria un SERVICE ACOUNT para cada ambiente en:
IAM
GITHUB Secrets
Kubernetes Secrets

## Configuracion de la aplicacion
Parametrizar en Kubernetes:
Numero de replicas
Nivel de Logging
Recursos de CPU y Memoria







