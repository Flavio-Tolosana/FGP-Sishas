	<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularUsuarioDAO" import="model.VO.UsuarioVO"%>

<!-------------------------------------------------------------
|	 Pantalla para que los clientes inicien sesión            |
-------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="css/sytleIndex.css">
</head>
<body>
	<div class="container">
		<h1>Iniciar Sesión</h1>
		<form action="SvIniciarSesionCliente" method="post">
		
			<label for="email">Correo Electrónico:</label>
			<input class="intro" type="email" id="email" name="email" required><br><br>

			<label for="contrasena">Contraseña:</label>
			<input class="intro" type="password" id="contrasegna" name="contrasegna" required><br>
			
			<!-- Mensaje de error -->
			<% if (request.getAttribute("error") != null) { %> 
			<div class="error">
			<%= request.getAttribute("error") %>
			</div><br>
			<% } %>

			<input class="inpIniciarSesion" type="submit" value="Iniciar Sesión">  <br><br><br>
		</form>

		<a href="registrarCliente.jsp" class="registar">Registrarse</a>  <br><br><br>
		<a href="index.jsp" class="volver">Volver</a>
		
	</div>
</body>
</html>