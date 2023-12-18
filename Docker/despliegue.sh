#!/bin/bash

# Paramos y borramos la versión anterior del portal, si existe
docker stop sisinf-database 2> /dev/null
docker rm sisinf-database 2> /dev/null

# Dentro de la carpeta postgres
cd postgres

# Creamos una imagen a partir del Dockerfile que se encuentra en esa carpeta
docker build -t sisinf/postgresql:latest .

# Creamos el contenedor de la base de datos
docker run --name sisinf-database -e ALLOW_EMPTY_PASSWORD=yes -p 5432:5432 -d sisinf/postgresql:latest

cd ..

# Paramos y borramos la versión anterior del portal, si existe
docker stop sisinf-tomcat 2> /dev/null
docker rm sisinf-tomcat 2> /dev/null

# Dentro de la carpeta tomcat
cd tomcat

# Creamos una imagen a partir del Dockerfile que se encuentra en esa carpeta
docker build -t sisinf/tomcat:latest .

# Creamos el contenedor de tomcat
docker run -d --name sisinf-tomcat \
-e ALLOW_EMPTY_PASSWORD=yes \
--link sisinf-database \
-p 8080:8080 \
sisinf/tomcat:latest

