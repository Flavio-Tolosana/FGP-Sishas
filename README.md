# FGP - SISHAS

### Resumen:
El sistema de información es una tienda online de cachimbas. En ella se
venden cachimbas, elementos de una cachimba y existe la opción de crear una
cachimba a su gusto. Además hay un apartado de segunda mano. Los usuarios
pueden contactar con la tienda a través del sistema para vender una cachimba.
Si la tienda decide comprarla, aparecerá en el apartado de cachimbas de
segunda mano.

### [Memoria del trabajo](memoria.pdf)

## Explicación estructura proyecto

- Se ha empleado eclipse para realizar la pagina web. En el directorio [src-web](src-web/), se encuantra el código fuente del proyecto. Hay dos subcarpetas principales. 
1. [src/main/java](src-web/src/main/java/): código que da la lógica a la página web.

    1.1. [db](src-web/src/main/java/db/): código para realizar las conexiones a la base de datos `Postgresql`.

    1.2. [model/DAO](src-web/src/main/java/model/DAO/): código para manipular los datos de la base de datos. `DAO: Data Access Object`

    1.3. [model/VO](src-web/src/main/java/model/VO/): código para declarar clases para tranportar información de la base de datos. `VO: Value Object`

2. [WebContent](src-web/WebContent/): código `jsp` para la creación de las pantallas de la web.

### Estructura en forma de árbol
``` bash
# Generado con el comando tree
.
├── src
│   └── main
│       └── java
│           ├── db
│           │   ├── ConnectionManager.java
│           │   └── PoolConnectionManager.java
│           ├── model
│           │   ├── DAO
│           │   │   ├── ManipularCarritoDAO.java
│           │   │   ├── ManipularCompraDAO.java
│           │   │   ├── ManipularProductoDAO.java
│           │   │   └── ManipularUsuarioDAO.java
│           │   └── VO
│           │       ├── AtributosTipoVO.java
│           │       ├── AtributosVO.java
│           │       ├── CarritoVO.java
│           │       ├── ComprasVO.java
│           │       ├── ProductoVO.java
│           │       ├── TiposVO.java
│           │       └── UsuarioVO.java
│           └── servlet
│               ├── admin
│               │   ├── SvAceptarCompra.java
│               │   ├── SvAgnadirUnidades.java
│               │   ├── SvDecisionProducto.java
│               │   ├── SvEliminarProducto.java
│               │   ├── SvModificarPrecio.java
│               │   ├── SvRechazarCompra.java
│               │   ├── SvSubirFotoProducto.java
│               │   └── SvSubirProductoAdmin.java
│               ├── carrito
│               │   ├── SvAddCarrito.java
│               │   ├── SvEliminarCarrito.java
│               │   ├── SvProcesarCompra.java
│               │   └── SvUpdateCarrito.java
│               ├── montarCachimba
│               │   ├── SvAgnadirMontarCachimbaCarrito.java
│               │   ├── SvEliminarMontarCachimba.java
│               │   └── SvSeleccionarMontarCachimba.java
│               ├── SvCerrarSesionAdmin.java
│               ├── SvCerrarSesion.java
│               ├── SvIniciarSesionAdmin.java
│               ├── SvIniciarSesionCliente.java
│               ├── SvIrCategoria.java
│               ├── SvRegistrarAdmin.java
│               ├── SvRegistrarCliente.java
│               ├── SvVerProducto.java
│               └── vender
│                   ├── SvAceptarPrecio.java
│                   ├── SvEliminarProductoRechazado.java
│                   ├── SvRechazarPrecio.java
│                   ├── SvSubirFotoVender.java
│                   └── SvSubirProductoUsu.java
└── WebContent
    ├── carrito.jsp
    ├── css
    │   ├── agnadirProductoStyle.css
    │   ├── styles.css
    │   ├── sytleIndex.css
    │   └── sytleRegistrar.css
    ├── direccion_compra.jsp
    ├── historialCompras.jsp
    ├── imagenes
    │   ├── agnadirProducto.png
    │   ├── desea_vender.png
    │   ├── montar_cachimba.png
    │   └── productos
    │       ├── 10.png
    │       ├── 11.png
    │       ├── 12.png
    │       ├── 13.png
    │       ├── 14.png
    │       ├── 15.png
    │       ├── 16.png
    │       ├── 17.png
    │       ├── 18.png
    │       ├── 19.png
    │       ├── 1.png
    │       ├── 20.png
    │       ├── 21.png
    │       ├── 22.png
    │       ├── 23.png
    │       ├── 24.png
    │       ├── 25.png
    │       ├── 26.png
    │       ├── 27.png
    │       ├── 28.png
    │       ├── 29.png
    │       ├── 2.png
    │       ├── 30.png
    │       ├── 31.png
    │       ├── 32.png
    │       ├── 33.png
    │       ├── 34.png
    │       ├── 35.png
    │       ├── 36.png
    │       ├── 37.png
    │       ├── 38.png
    │       ├── 39.png
    │       ├── 3.png
    │       ├── 4.png
    │       ├── 5.png
    │       ├── 6.png
    │       ├── 7.png
    │       ├── 8.png
    │       └── 9.png
    ├── index.jsp
    ├── infoCompra.jsp
    ├── iniciarSesionAdmin.jsp
    ├── iniciarSesionCliente.jsp
    ├── js
    │   └── agnadirAtributosExtra.js
    ├── META-INF
    │   └── MANIFEST.MF
    ├── pagar_carrito.jsp
    ├── pantallaAceptarRechazarOferta.jsp
    ├── pantallaAgnadirProducto.jsp
    ├── pantallaCategoria.jsp
    ├── pantallaCobro.jsp
    ├── pantallaInformacionProducto.jsp
    ├── pantallaListadoVentas.jsp
    ├── pantallaMontarCachimbas.jsp
    ├── pantallaPrincipalAdmin.jsp
    ├── pantallaPrincipal.jsp
    ├── pantallaProducto.jsp
    ├── pantallasPropuestasComprar.jsp
    ├── pantallaSubirFotoProducto.jsp
    ├── pantallaSubirFotoVentas.jsp
    ├── pantallaVentas.jsp
    ├── registrarAdmin.jsp
    ├── registrarCliente.jsp
    └── WEB-INF
        ├── lib
        │   ├── postgresql-42.2.5.jar
        │   ├── servlet-api.jar
        │   ├── taglibs-standard-compat-1.2.5.jar
        │   ├── taglibs-standard-impl-1.2.5.jar
        │   ├── taglibs-standard-jstlel-1.2.5.jar
        │   └── taglibs-standard-spec-1.2.5.jar
        └── web.xml
```

## Creación Dynamic Web Project en Eclipse

1. Clickar con botón derecho en `Project Explorer` y seleccionar **New -> Dynamic Web Project**

2. Completar:
    - Project Name
    - Dynamic web module version (en mi caso, 3.0)
    - Source folders on build path: **src/main/java** y Output folder: **build/classes**
    - Context root: ***Nombre proyecto*** y Content directory: **/WebContent**. Se recomienda marcar el checkbox de: *Generate web.xml deployment descriptor*

3. Colocar ficheros y directorios en sus carpetas correspondientes.

4. Poner las propiedades al proyecto. Click derecho en proyecto y clickar **Properties**
    - Poner `Java Build Path`. Clickar en *Libraries*, *Classpath* y *Add Jars*. Seleccionar los jars disponibles en la carpeta [src-web/WebContent/WEB-INF/lib/](src-web/WebContent/WEB-INF/lib/). 

    <img src="img\Java-Build-Path.png"/>

    - Poner `Deployment Assembly`. Clickar en *Add*, *Java Build Path Entries* y seleccionar Jars previamente añadidos a Java Build Path.

    <img src="img\Deployment-Assembly.png"/>

## Despliegue en Docker

### Contenido carpeta Docker

En la carpeta [Docker](Docker/) se encuentran dos subcarpetas y el script que crea las imagenes y los contenedores.

- [postgres](Docker/postgres/)
    - [Dockerfile](Docker/postgres/Dockerfile): crear imagen a partir de: `bitnami/postgresql:16.1.0`
    - [crear_BD.sql](Docker/postgres/crear_BD.sql): script .sql que crea la base de datos y la inicia. 

- [tomcat](Docker/tomcat/)
    - [context.xml](Docker/tomcat/context.xml) y [server.xml](Docker/tomcat/server.xml) han sido sacados de un servidor *Apache-tomcat-9.0.83*
    - [Dockerfile](Docker/tomcat/Dockerfile): crear imagen a partir de: `bitnami/tomcat:9.0.83`
    - [ROOT.war](Docker/tomcat/ROOT.war): archivo **WAR** del proyecto. `WAR (Web Application Resource)`
    - [postgresql-42.2.5.jar](Docker/tomcat/postgresql-42.2.5.jar): controlador de la base de datos. El mismo que se encuentra en la carpeta [WEB-INF](src-web/WebContent/WEB-INF/).

- [despliegue.sh](Docker/despliegue.sh): script para poner en funcionamiento y crear los contenedores.

### Explicación despliegue

1. Generar el archivo `ROOT.war`. Click derecho en el proyecto, **Export -> WAR file**. Se debe colocar en la carpeta [Docker/tomcat/](Docker/tomcat/)

2. Dar permisos de ejecución al script [despliegue.sh](Docker/despliegue.sh). 
    ``` bash
    chmod u+x despliegue.sh
    ```

3. Antes de ejecutar el script asegurarse que, si tienes una base de datos en local *postgresql*, pararla.
    ``` bash
    sudo systemctl stop postgresql
    ```

4. Ejecutar script
    ``` bash
    ./despliegue.sh
    ```

5. Si todo ha ido bien, en un navegador se debería ver en la dirección `localhost:8080` la siguiente imagen:

<img src="img\Pantalla-Web.png"/>

## Versiones tecnología utilizada

- **Eclipse:** Version: 2023-06 (4.28.0)
- **DBeaver (extensión eclipse):** 23.3.0
- **Postgresql**: psql (PostgreSQL) 16.1 (Ubuntu 16.1-1.pgdg23.04+1)
- **Apache-tomcat:** tomcat:9.0.83
- **Docker:** Docker version 24.0.7
