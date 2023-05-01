# EduHub <!-- omit in toc -->

- [1. Diagramas](#1-diagramas)
  - [1.1. Diagrama De Arquitectura](#11-diagrama-de-arquitectura)
  - [1.2. Diagrama De La Base De Datos](#12-diagrama-de-la-base-de-datos)
- [2. Guía De Instalación](#2-guía-de-instalación)
- [3. Uso Del Programa](#3-uso-del-programa)
- [4. Pruebas Realizadas](#4-pruebas-realizadas)
- [5. Resultados De Pruebas Unitarias](#5-resultados-de-pruebas-unitarias)
- [6. Conclusiones Y Recomendaciones](#6-conclusiones-y-recomendaciones)
  - [6.1. Conclusiones](#61-conclusiones)
  - [6.2. Recomendaciones](#62-recomendaciones)

## 1. Diagramas

### 1.1. Diagrama De Arquitectura

![Diagrama de arquitectura](docs/resources/diagrams/architecture-diagram.png)

### 1.2. Diagrama De La Base De Datos

![Diagrama de la base de datos](docs/resources/diagrams/db-diagram.png)

## 2. Guía De Instalación

1. Seguir los pasos del [README de la infraestructura](./src/infrastructure/README.md)
    * Las variables de entorno hay que cambiarlas para que correspondan con los datos de la infraestructura recien creada
2. Instalar [Docker Desktop](https://www.docker.com/products/docker-desktop/)
3. Ir al directorio **src/docker**
4. Ejecutar el archivo **build-api.bat**
    * Desde consola:
    
        ```bash
        .\build-api.bat
        ```

    * Desde el explorador de archivos solo hay que dar doble click al archivo

5. Una vez terminado, para verificar que funcione el api, se debe ir a su cuenta de [Azure](https://azure.microsoft.com/es-es/get-started/azure-portal)
6. Dentro de Microsoft Azure se debe buscar **main-app**
7. Dentro de **main-app** en **Overview** se encuentra la url del api donde dice **Application Url**.
8. Abrir el link.
9. Si todo está correcto se desplegará lo siguiente en el navegador:

![Página principal API](docs/resources/imgs/api-main-page.png)

## 3. Uso Del Programa

## 4. Pruebas Realizadas

## 5. Resultados De Pruebas Unitarias

## 6. Conclusiones Y Recomendaciones

### 6.1. Conclusiones

### 6.2. Recomendaciones