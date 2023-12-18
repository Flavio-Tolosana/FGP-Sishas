<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set" %>
<!-- Muestra la informacion de los productos en espera a realizar oferta o ser rechazados si clicas en alguno de ellos te dirige a PantallaAceptarRechazarOferta.jsp. -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
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
    
    <br><br>
    
    <h1>FGP SISHAS</h1>
    
    <br><br>
    
    <!-- Mensaje producto rechazado / aceptado -->
    <% if (request.getAttribute("mensaje") != null) { %> 
        <div id="mensaje" class="mensaje"><%=request.getAttribute("mensaje")%></div>
		<script>
		        // Después de 6000 milisegundos (6 segundos), ocultar el mensaje
		        setTimeout(function() {
		            document.getElementById("mensaje").style.display = "none";
		        }, 6000);
		</script>
    <% } %>
		
	<h2>Productos de clientes</h2>
	<div class="products">
		<% // Obtener productos estén en espera, de segunda mano
			ManipularProductoDAO dao = new ManipularProductoDAO();
			Set<ProductoVO> listaProductos = dao.listaProductos(false, "Espera");
			if (listaProductos.isEmpty()) {     // Lista vacía
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en espera</p>
			</div>
		<%
			}
			else {       // Iterar sobre la lista sacando los datos
				for (ProductoVO producto : listaProductos) {
		%>
		<div class="product">
			<img src=<%=producto.getUrlFoto()%>><br>
			<table>
				<tr>
					<td><b class="label">Nombre:</b></td>  
					<td><%=producto.getNombre() %></td>
				</tr>
				<tr>
					<td><b class="label">Marca:</b></td>  
					<td><%=producto.getMarca() %></td>
				</tr>
				<tr>
					<td><b class="label">Color:</b></td>
					<td><%=producto.getColor()%> </td>
				</tr>
				<tr>
					<td><b class="label">Tipo Producto:</b></td>    
					<td><%=producto.getNombreTipoProducto() %></td>
				</tr>
			</table>
			<br>
			<form action="SvDecisionProducto" method="post">
				<button type="submit" name="verProducto" class="ver" value="<%=producto.getIdProducto()%>">
					Aceptar / Rechazar
				</button>
			</form><br>
		</div>	
		<%
			}
		}
		%>
	</div><br><br>
	<div class="botones">
		<a href="pantallaPrincipalAdmin.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</html>
