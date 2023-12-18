<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!----------------------------------------------------------------------------------------------------
|	Pantalla para registrar a un cliente.                                                            |
----------------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="css/sytleRegistrar.css">
</head>
<body>
	<div class="container">
		<h1>Registrarse</h1>
		<form action="SvRegistrarCliente" method="post"> 
		
			<label for="nombre">Nombre:</label>
			<input class="intro" type="text" id="nombre" name="nombre" required><br>
		
			<label for="apellidos">Apellidos:</label>
			<input class="intro" type="text" id="apellidos" name="apellidos" required><br>
			
			<label for="email">Correo Electronico:</label>
			<input class="intro" type="email" id="email" name="email" required><br>
			
			<label for="pwd">Contraseña:</label>
			<input class="intro" type="password" id="pwd" name="pwd" required><br>
			
			<label for="tel">Nuero telefono:</label>
			<input class="intro" type="number" id="tel" name="tel" pattern="[0-9]{9}" required><br>
			<small>Ejemplo: 658785498 (9 dígitos)</small>
			
			<label for="codpostal">Código Postal:</label>
			<input class="intro" type="number" id="codpostal" name="codpostal" pattern="[0-9]{5}" required><br>
			<small>Ejemplo: 50014 (5 dígitos)</small>
			
			<label for="calle">Calle:</label>
			<input class="intro" type="text" id="calle" name="calle" required><br>
			
			<label for="pisoPuerta">Piso y Puerta:</label>
			<input class="intro" type="text" id="pisoPuerta" name="pisoPuerta" required><br><br>
			
			<!-- Mensaje de error -->
			<% if (request.getAttribute("error") != null) { %> 
			<div class="error">
			<%= request.getAttribute("error") %>
			</div><br>
			<% } %>
			
			<input class="inpIniciarSesion" type="submit" value="Registrarse">  <br><br><br>
			<a href="index.jsp" class="volver">Volver</a>  
		</form>
	</div>
</body>
</html>

