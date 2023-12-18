<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.DAO.ManipularCarritoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set"%>

<!------------------------------------------------------------------------------------------- 
|	Pantalla del carrito de un usuario.                                                      |
|	Puede eliminar los productos del carrito y modificar las cantidades seleccionadas.       |
|	Además hay retroalimentación sobre si es posible realizar la compra de dicho producto.   |
--------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
 	<script>
		// Incrementar contador del producto del carrito
        function incrementar(id) {
            var cantidadElemento = document.getElementById(id);
            var cantidad = parseInt(cantidadElemento.value, 10);
            cantidad++;
            cantidadElemento.value = cantidad;
        }

		// Decrementar contador del producto del carrito
        function decrementar(id) {
            var cantidadElemento = document.getElementById(id);
            var cantidad = parseInt(cantidadElemento.value, 10);
            if (cantidad > 0) {
                cantidad--;
                cantidadElemento.value = cantidad;
            }
        }
	</script>
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
	<div>
		<div class="indiceCarrito">
			<h1>Carrito de compra</h1>
			<h2 class="medio">Datos envío</h2>
			<h2>Método pago</h2>
		</div>

		<hr class="linea">
		
		<!-- Productos del carrito -->
		<h2>Productos del Carrito</h2>
		
		<!-- Mensaje carrito actualizado / Mensaje producto eliminado carrito -->
	    <% if (request.getAttribute("mensaje") != null) { %> 
	        <div id="mensaje" class="mensaje"><%=request.getAttribute("mensaje")%></div>
			<script>
			        // Después de 6000 milisegundos (6 segundos), ocultar el mensaje
			        setTimeout(function() {
			            document.getElementById("mensaje").style.display = "none";
			        }, 6000);
			</script>
	    <% } %>
	    
	    <!-- Mensaje de error -->
		<% if (request.getAttribute("error") != null) { %> 
		<div class="error">
		<%= request.getAttribute("error") %>
		</div><br>
		<% } %>

		<!-- Cada producto del carrito -->
		<div class="products">
			<%  
			if (cliente == null) {
				request.setAttribute("error", "Sesión caducada");
				request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
			}
			ManipularCarritoDAO dao = new ManipularCarritoDAO();
			Set<ProductoVO> listaCarrito = dao.listaCarrito(cliente.getCorreoElectronico());
			if (listaCarrito != null && listaCarrito.isEmpty()) {   // Carrito vacío
			%>
			<div class="error">
				<p style="text-align: center;">No hay productos en el carrito</p>
			</div>
			<% } else {   // Iterar sobre lista productos
					for (ProductoVO producto : listaCarrito) {%>
			<div class="product">
				<img src=<%=producto.getUrlFoto()%>><br>
				<table>
					<tr>
						<td><b class="label">Nombre:</b></td>  
						<td><%=producto.getNombre() %></td>
					<tr>
						<td><b class="label">Precio (1 ud):</b></td>
						<td><%=producto.getPrecio().toString() %> €</td>
					</tr>
					<tr>
						<td><b class="label">Tipo Producto:</b></td>    
						<td><%=producto.getNombreTipoProducto() %></td>
					</tr>
					<tr>
						<td><b class="label">Estado:</b></td>    
						<td><%=producto.getEstadoProducto() %></td>
					</tr>
					<% int posibleCompra = dao.posibleCompra(cliente.getCorreoElectronico(), producto.getIdProducto());
					if (posibleCompra == -1) {   // Es posibleCompra %>
					<tr>
						<td><b class="label">Stock:</b></td>    
						<td style="color: green;">Quedan unidades</td>
					</tr>
					<%} else {  // No es posible compra %>
					<tr>
						<td><b class="label">Stock:</b></td>    
						<td style="color: red;">Quedan <%=posibleCompra%> unidades</td>
					</tr>
					<%} %>
				</table><br>
				<!-- Actualizar producto carrito -->
				<form action="SvUpdateCarrito" method="post">
					<div class="formulario-carrito">
						<button class="menos" type="button" onclick="decrementar('<%=producto.getIdProducto()%>')">-</button>
							<input type="number" id="<%=producto.getIdProducto()%>" name="<%=producto.getIdProducto()%>" value="<%= producto.getUnidades() %>" readonly>
						<button class="mas" type="button" onclick="incrementar('<%=producto.getIdProducto()%>')">+</button>
						<button type="submit" name="updateCarrito" value="<%=producto.getIdProducto()%>" class="update-carrito">Actualizar Carrito</button>
					</div>
				</form>
				<!-- Eliminar producto carrito -->
				<form action="SvEliminarCarrito" method="post">
					<div class="formulario-carrito">
						<button type="submit" name="eliminarCarrito" value="<%=producto.getIdProducto()%>" class="eliminarCarrito">Eliminar</button>
					</div>
				</form>
			</div>	
			<%
					}
				}
			%>
		</div>

		<!-- Botones de siguiente pantalla y volver pantalla principal -->
		<div class="botones">
			<%
			if (listaCarrito != null && !listaCarrito.isEmpty()) {   // Carrito no vacío
			%>
			<a href="direccion_compra.jsp" class="sig">Siguiente</a><br><br><br>
			<%}%>
			<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
		</div>
	</div>
</body>
</html>
