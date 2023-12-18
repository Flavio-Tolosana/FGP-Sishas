<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularUsuarioDAO"%>

<!-------------------------------------------------------------
|	 Pantalla para que los administradores inicien sesión     |
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
        <h1>Iniciar Sesión Administrador</h1>
        <form action="SvIniciarSesionAdmin" method="post">
        
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
            <a href="index.jsp" class="volver">Volver</a>
        </form>
    </div>

</body>
</html>