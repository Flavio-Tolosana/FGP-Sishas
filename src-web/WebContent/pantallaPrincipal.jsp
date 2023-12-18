<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set" %>

<!----------------------------------------------------------------------------------------------------------------
|	Pagina principal del sistema información. Ya para los usuarios que han sido registrados.                     |
|	Pueden cerrar sesión, ver el carrito, ver el historial de compras, mirar tipos de productos,                 |
|	añadir productos de primera y segunda mano al carrito, montar cachimba y vender cachimba.                    |
----------------------------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<script>
		// Alerta de que el producto se ha agotado
		function alertaProductoAgotado(){
			alert("Producto AGOTADO");
		}
		
		// Incrementa en uno el valor de uno de los contadores de los productos
		function incrementar(id) {
			var cantidadElemento = document.getElementById(id);
			var cantidad = parseInt(cantidadElemento.value, 10);
			cantidad++;
			cantidadElemento.value = cantidad;
		}

		// Decrementa en uno el valor de uno de los contadores de los productos
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
    
    <br><br>
    
    <h1>FGP SISHAS</h1>
    
    <br><br>

	<!-- Para acceder a los tipos de producto -->
    <div class="navigation">
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="2">Cachimbas</button>
    	</form>
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="3">Bases</button>
    	</form>
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="4">Mástiles</button>
    	</form>
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="5">Cazoletas</button>
    	</form>
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="1">Mangueras</button>
    	</form>
    	<form action="SvIrCategoria" method="post">
    		<button name="idTipo" type="submit" value="6">Accesorios</button>
    	</form>
    </div>

	<!-- Opciones de Montar cachimba y Vender Cachimba -->
    <div class="options">
        <div class="option1" onclick="window.location.href='pantallaMontarCachimbas.jsp';">
            <img src="imagenes/montar_cachimba.png" alt="Monta tu propia cachimba"><br>
            <p>Monta tu propia cachimba</p>
        </div>

        <div class="option2" onclick="window.location.href='pantallaVentas.jsp';">
            <img src="imagenes/desea_vender.png" alt="Desea vender"><br>
            <p>Desea vender</p>
        </div>
    </div>
	
	<!-- Mensaje producto añadido / Mensaje compra realizada -->
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
	
	<!-- Productos de primera mano -->
	<h2>Productos Primera Mano</h2>
	<div class="products">
		<% // Obtener productos de Primera Mano
			ManipularProductoDAO dao = new ManipularProductoDAO();
			Set<ProductoVO> listaProductosPrimeraMano = dao.listaProductos(true, "Vendido");
			if (listaProductosPrimeraMano.isEmpty()) {   // No hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {   // Iterar para obtener los productos
				for (ProductoVO producto : listaProductosPrimeraMano) {
		%>
		<!-- Cada producto de primera mano -->
		<div class="product">
			<img src=<%=producto.getUrlFoto()%>><br>
			<table>
				<tr>
					<td><b class="label">Nombre:</b></td>  
					<td><%=producto.getNombre() %></td>
				<tr>
					<td><b class="label">Precio:</b></td>
					<td><%=producto.getPrecio().toString() %> €</td>
				</tr>
				<tr>
					<td><b class="label">Tipo Producto:</b></td>    
					<td><%=producto.getNombreTipoProducto() %></td>
				</tr>
				<tr>
					<td><b class="label">Disponibilidad:</b></td>
					<% if (producto.getUnidades() == 0) {%>    
					<td style="color:red;">AGOTADO</td>
					<% } else { %>
					<td style="color:green;">Quedan unidades</td>
					<%} %>
				</tr>
			</table><br>
			<!-- Contador unidades seleccionadas -->
			<% if (producto.getUnidades() == 0) {%>    
			<div class="formulario-carrito">
				<button type="button" onclick="decrementar('<%=producto.getIdProducto()%>')">-</button>
				<input type="number" id="<%=producto.getIdProducto()%>" name="<%=producto.getIdProducto()%>" value="0" readonly>
				<button type="button" onclick="incrementar('<%=producto.getIdProducto()%>')">+</button>
				<button class="add-to-carrito" onclick="alertaProductoAgotado()">
					<i class="fas fa-cart-plus"></i>Añadir al carrito
				</button>
			</div>
			<form class="ancho" action="SvVerProducto" method="post">
				<button name="idProducto" class="ver" type="submit" value="<%=producto.getIdProducto()%>">Ver producto</button>
			</form>
			<% } else { %>
			<form action="SvAddCarrito" method="post">
				<div class="formulario-carrito">
					<button class="menos" type="button" onclick="decrementar('<%=producto.getIdProducto()%>')">-</button>
					<input type="number" id="<%=producto.getIdProducto()%>" name="<%=producto.getIdProducto()%>" value="0" readonly>
					<button class="mas" type="button" onclick="incrementar('<%=producto.getIdProducto()%>')">+</button>
					<button type="submit" name="addCarrito" value="<%=producto.getIdProducto()%>" class="add-to-carrito">
						<i class="fas fa-cart-plus"></i>Añadir al carrito
					</button>
				</div>
			</form>
			<form class="ancho" action="SvVerProducto" method="post">
				<button name="idProducto" class="ver" type="submit" value="<%=producto.getIdProducto()%>">Ver producto</button>
			</form>
			<%} %>
		</div>	
		<%
				}
			}
		%>
	</div>
	    
	<!-- Productos de segunda mano -->
	<h2>Productos Segunda Mano</h2>
	<div class="products">
		<% // Obtener productos de Segunda Mano
			Set<ProductoVO> listaProductosSegundaMano = dao.listaProductos(false, "Vendido");
			if (listaProductosSegundaMano.isEmpty()) {   // No quedan productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {     // Iterar para obtener los productos
				for (ProductoVO producto : listaProductosSegundaMano) {
		%>
		<!-- Cada producto de sergunda mano -->
		<div class="product">
			<img src=<%=producto.getUrlFoto()%>><br>
			<table>
				<tr>
					<td><b class="label">Nombre:</b></td>  
					<td><%=producto.getNombre() %></td>
				<tr>
					<td><b class="label">Precio:</b></td>
					<td><%=producto.getPrecio().toString() %> €</td>
				</tr>
				<tr>
					<td><b class="label">Tipo Producto:</b></td>    
					<td><%=producto.getNombreTipoProducto() %></td>
				</tr>
				<tr>
					<td><b class="label">Disponibilidad:</b></td>
					<% if (producto.getUnidades() == 0) {%>    
					<td style="color:red;">AGOTADO</td>
					<% } else { %>
					<td style="color:green;">Quedan unidades</td>
					<%} %>
				</tr>
			</table><br>
			<!-- Contador unidades seleccionadas -->
			<% if (producto.getUnidades() == 0) {%>    
			<div class="formulario-carrito">
				<button type="button" onclick="decrementar('<%=producto.getIdProducto()%>')">-</button>
				<input type="number" id="<%=producto.getIdProducto()%>" name="<%=producto.getIdProducto()%>" value="0" readonly>
				<button type="button" onclick="incrementar('<%=producto.getIdProducto()%>')">+</button>
				<button class="add-to-carrito" onclick="alertaProductoAgotado()">
					<i class="fas fa-cart-plus"></i>Añadir al carrito
				</button>
			</div>
			<form class="ancho" action="SvVerProducto" method="post">
				<button name="idProducto" class="ver" type="submit" value="<%=producto.getIdProducto()%>">Ver producto</button>
			</form>
			<% } else { %>
			<form action="SvAddCarrito" method="post">
				<div class="formulario-carrito">
					<button class="menos" type="button" onclick="decrementar('<%=producto.getIdProducto()%>')">-</button>
					<input type="number" id="<%=producto.getIdProducto()%>" name="<%=producto.getIdProducto()%>" value="0" readonly>
					<button class="mas" type="button" onclick="incrementar('<%=producto.getIdProducto()%>')">+</button>
					<button type="submit" name="addCarrito" value="<%=producto.getIdProducto()%>" class="add-to-carrito">
						<i class="fas fa-cart-plus"></i>Añadir al carrito
					</button>
				</div>
			</form>
			<form class="ancho" action="SvVerProducto" method="post">
				<button name="idProducto" class="ver" type="submit" value="<%=producto.getIdProducto()%>">Ver producto</button>
			</form>
			<%} %>
		</div>	
		<%
			}
		}
		%>
	</div>
</body>
</html>