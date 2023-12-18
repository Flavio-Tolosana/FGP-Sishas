<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!----------------------------------------------------------------------------------------------------
|	Pantalla para registrar a un administrador. Solo lo puede registrar otro administrador            |
------------------------------------------------------------------------------------------------------>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="css/sytleRegistrar.css">
</head>
<body>
	<div class="container">
		<h1>Registrar Administrador</h1>
		<form action="SvRegistrarAdmin" method="post"> 
		
			<label for="nombre">Nombre:</label>
			<input class="intro" type="text" id="nombre" name="nombre" required><br>
		
			<label for="apellidos">Apellidos:</label>
			<input class="intro" type="text" id="apellidos" name="apellidos" required><br>
			
			<label for="email">Correo Electronico:</label>
			<input class="intro" type="email" id="email" name="email" required><br>
			
			<label for="pwd">Contraseña:</label>
			<input class="intro" type="password" id="pwd" name="pwd" required><br><br>
			
			<!-- Mensaje de error -->
			<% if (request.getAttribute("error") != null) { %> 
			<div class="error">
			<%= request.getAttribute("error") %>
			</div><br>
			<% } %>
			
			<input class="inpIniciarSesion" type="submit" value="Registrar">  <br><br><br>
			<a href="pantallaPrincipalAdmin.jsp" class="volver">Volver</a>  
		</form>
	</div>
</body>
</html>

