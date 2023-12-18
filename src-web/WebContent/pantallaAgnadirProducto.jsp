<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="model.VO.UsuarioVO"%>
<!-- Recopila la información introducida por el admin sobre el producto y lo añade a la base de datos. -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FGP SISHAS</title>
    <link rel="stylesheet" href="css/agnadirProductoStyle.css">
    <link rel="stylesheet" href="css/styles.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <script src="js/agnadirAtributosExtra.js"></script>
</head>
<body>
	<!-- Cabecera administrador -->
    <div class="header">
    	<div class="info_cliente">
    	<% UsuarioVO admin = (UsuarioVO) session.getAttribute("admin");
		if (admin == null) {
			request.setAttribute("error", "Sesión caducada");
			request.getRequestDispatcher("iniciarSesionAdmin.jsp").forward(request, response);
		}%>
    		<p><b>ADMINISTRADOR:</b></p><p><%=admin.getNombre()%></p><p> <%=admin.getApellidos()%></p><p>(<%=admin.getCorreoElectronico()%>)</p>
    	</div>
		<a href="pantallaPrincipalAdmin.jsp">
			<i class="fas fa-home"></i> Inicio
		</a>
    	<a href="SvCerrarSesionAdmin">Cerrar Sesion</a>
		<a href="registrarAdmin.jsp">Registrar administrador</a>
    </div>

    <h1>Añadir Producto</h1>

    <!-- Formulario para subir un producto por el admin -->
    <form action = "SvSubirProductoAdmin" method = "post" >
        <!-- Div que contiene La informacion del producto -->
        <div class="container">            
            <label for="nombre">Nombre del producto:</label>
			<input type="text" id="nombre" name="nombre" required /><br><br>
			
			<label for="marca">Marca del producto:</label>
			<input type="text" id="marca" name="marca" required /><br><br>
			
			<label for="color">Color del producto:</label>
			<input type="text" id="color" name="color" required /><br><br>       
			
			<label for="unidades">Unidades del producto:</label>
			<input type="number" id="unidades" name="unidades" min="0" required /><br><br>       
			
			<label for="precio">Precio del producto:</label>
			<input type="number" step="any" id="precio" name="precio" min="0"  required /><br><br>                                      
        </div><br><br>

        <!-- Seleccion del tipo de producto -->
        <div class="container">
            <label for="nombreTipoProducto">Tipo del producto:</label>
            <select name="nombreTipoProducto" id="tipoProducto">
                <option disabled selected value="">Elige una opción</option>
                <option value="accesorio">Accesorio</option>
                <option value="mastil">Mástil</option>
                <option value="cachimba">Cachimba completa</option>
                <option value="cazoleta">Cazoleta</option>
                <option value="manguera">Mangueras</option>
                <option value="base">Base</option>
            </select>
        </div>

        <br> 

        <!--Atributos extra de cada tipo de producto solo se mostrará un div 
            dependiendo de lo que seleccionen en tipoProducto -->
        <div class = "atributo_extra_Accesorio">
            Tipo de accesorio: <input type="text" name="accesorio" /><br>
        </div>
        <div class = "atributo_extra_Mastil">
            Encaje en cm: <input type="text" name="mastil" /><br>
        </div>
        <div class = "atributo_extra_Cachimba-completa">
            Altura en cm: <input type="number" name="cachimba" /><br>
        </div>
        <div class = "atributo_extra_Cazoleta">
            <label for="tipoCazoleta">Tipo de la cazoleta:</label>
            <select name="cazoleta" id="Atributoextra0">
                <option disabled selected value="">Elige una opción</option>
                <option value="Phunnel">Phunnel</option>
                <option value="Tradi">Tradi</option>
            </select>
        </div>
        <div class = "atributo_extra_Mangueras">
            Largura en cm: <input type="number" name="manguera" /><br>
        </div>
        <div class = "atributo_extra_Base">
            Encaje en cm: <input type="number" name="base" /><br>
        </div>

        <!-- Div que contiene el boton de enviar -->
        <div class="enviar_informacion">    
        	<button class="ver" type="submit" id="boton-vender" name="vender" value=0>Subir producto</button>       
        </div>
    </form>
    <br><br>
    <div class="botones">
		<a href="pantallaPrincipalAdmin.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>