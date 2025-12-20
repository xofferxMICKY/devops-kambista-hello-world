### Levantar infraestructura y aplicación
```bash
cd terraform
terraform init
terraform apply
```

### Acceso a la app
Ejecutar el comando en consola de GCP
```bash
kubectl get svc -n hello-world
``` 
En el navegador colocar: http://<EXTERNAL-IP>


### Cómo ejecutar el pipeline
El pipeline de CI/CD está implementado con GitHub Actions y se ejecuta automáticamente.
# Ejecución:
Cada push a la rama main dispara el pipeline.
No se requiere ejecución manual.


### Decisiones técnicas y justificaciones
# Seguridad
Se creó un Service Account dedicado para el pipeline, siguiendo el principio de menor privilegio.
Roles:
roles/artifactregistry.writer     # Publicar imágenes Docker
roles/container.developer         # Desplegar recursos en GKE
roles/container.clusterViewer     # Consultar estado del cluster

El proyecto tiene habilitada la política iam.disableServiceAccountKeyCreation, lo que impide el uso de claves estáticas.
Como solución segura, se implementó Workload Identity Federation entre GitHub Actions y GCP.
Esto permite autenticación sin claves, restringida únicamente al repositorio autorizado