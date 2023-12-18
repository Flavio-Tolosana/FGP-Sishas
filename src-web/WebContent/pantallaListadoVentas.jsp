<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set" %>

<!----------------------------------------------------------------------------------------------------------------
|	Página en la que se muestran todos los productos, tanto de primera como de segunda mano, de un tipo en       |
|   específico, elegido en la pantalla anterior.																 |
----------------------------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
</head>
<body>
	<!-- Cabecera donde aparece la inforamación del usuario -->
    <div class="header">
    	<div class="info_cliente">
    	<%
    	UsuarioVO cliente = (UsuarioVO) session.getAttribute("cliente");
		if (cliente == null) {
			request.setAttribute("error", "Sesión caducada");
			request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
		}
		%>
    		<p><%=cliente.getNombre()%></p><p> <%=cliente.getApellidos()%></p><p>(<%=cliente.getCorreoElectronico()%>)</p>
    	</div>
		<a href="pantallaPrincipal.jsp">
			<i class="fas fa-home"></i> Inicio
		</a>
    	<a href="SvCerrarSesion">Cerrar Sesion</a>
    	<a href="pantallaListadoVentas.jsp">Listado Ventas</a>
        <a class="carrito" href="carrito.jsp">
	    		<i class="fas fa-cart-plus"></i>Carrito</a>
	    <a href="historialCompras.jsp">Historial de Compras</a>
    </div>

	<!-- Mensaje producto subido con éxito -->
    <% if (request.getAttribute("mensaje") != null) { %> 
        <div id="mensaje" class="mensaje"><%=request.getAttribute("mensaje")%></div>
		<script>
		        // Después de 6000 milisegundos (6 segundos), ocultar el mensaje
		        setTimeout(function() {
		            document.getElementById("mensaje").style.display = "none";
		        }, 6000);
		</script>
    <% } %>
	
	<!-- Tabla de productos subidos -->
	<div class="products">
		<% // Obtener productos de Primera Mano
			ManipularProductoDAO dao = new ManipularProductoDAO();
			Set<ProductoVO> listaProductosVentas = dao.listaProductosVenta(cliente.getCorreoElectronico());
			if (listaProductosVentas.isEmpty()) {  // Si no hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No ha realizado ninguna venta</p>
			</div>
		<%
			}
			else {   // Iterar sobre el set para obtener los productos
		%>
	
		<table class="tablaVentas" border="1">
			<thead>
				<tr>
					<th>Nombre</th>
					<th>Estado</th>
					<th>Oferta</th>
					<th>¿Aceptar o rechazar?</th>
				</tr>
			</thead>
			<tbody>
			
				<%
				for (ProductoVO producto : listaProductosVentas) {
				%>
					<tr>
						<td><%=producto.getNombre()%></td>
					<% if (producto.getEstadoProducto().equals("Rechazado")) { %>
						<td><%=producto.getEstadoProducto()%>
							<div class=formulario-carrito>
								<form action="SvEliminarProductoRechazado" method="post">
									<button class="eliminarCarrito" type="submit" name="producto" value="<%=producto.getIdProducto()%>">
										Eliminar productoRechazado
									</button>
								</form>
							</div>
						</td>
					<% } else { %>
						<td><%=producto.getEstadoProducto()%></td>
						<% 
					    }
						if(producto.getEstadoProducto().equals("Oferta")){
						%>
							<td><%=producto.getPrecioVenta().toString()%> €</td>
							<td>
								<div class=formulario-ventas>
									<form action="SvAceptarPrecio" method="post">
										<button class="ver" type="submit" name="producto" value="<%=producto.getIdProducto()%>">
											Aceptar
										</button>
									</form>
									<form action="SvRechazarPrecio" method="post">
										<button class="eliminarCarrito" type="submit" name="producto" value="<%=producto.getIdProducto()%>">
											Rechazar
										</button>
									</form>
								</div>
							</td>
						<%
						} else {
						%>
							<td></td>
							<td></td>
						<%
						}
						%>
					</tr>	
			<%
				}
			%>

			</tbody>
		</table>		
		<%
			}
		%>
	</div>
	<br><br>
	<div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>