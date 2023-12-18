<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="java.util.HashSet" import="java.util.Set" import="model.VO.UsuarioVO"%>

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

	<% 
    int tipo = (int) request.getAttribute("idTipo");
	//int tipo = Integer.parseInt(idTipo);
	
    String tipoProducto = "";
    if (tipo == 1) {
        tipoProducto = "Mangueras";
    }
	else if(tipo == 2){
		tipoProducto = "Cachimbas";
	}
	else if(tipo == 3){
		tipoProducto = "Bases";
	}
	else if(tipo == 4){
		tipoProducto = "Mástiles";
	}
	else if(tipo == 5){
		tipoProducto = "Cazoletas";
	}
	else if(tipo == 6){
		tipoProducto = "Accesorios";
	}
    %>
	<!-- Lista productos primera mano -->
	<h2> <%=tipoProducto%> de Primera Mano</h2>
	<div class="products">
		<% // Obtener productos de Primera Mano
			ManipularProductoDAO dao = new ManipularProductoDAO();
			Set<ProductoVO> listaProductosPrimeraManoCategoria = dao.listaProductosCategoria(true, "Vendido", tipo);
			if (listaProductosPrimeraManoCategoria.isEmpty()) {  // Si no hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {     // Iterar para obtener los productos
				for (ProductoVO producto : listaProductosPrimeraManoCategoria) {
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

	<!-- Lista productos segunda mano -->
	<h2><%=tipoProducto%> de Segunda Mano</h2>
	<div class="products">
		
		<% // Obtener productos de Segunda Mano
			Set<ProductoVO> listaProductosSegundaManoCategoria = dao.listaProductosCategoria(false, "Vendido", tipo);
			
			if (listaProductosSegundaManoCategoria.isEmpty()) {   // Si no hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {     // Iterar para obtener los productos
				for (ProductoVO producto : listaProductosSegundaManoCategoria) {
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
	
	<br><br>
	<div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>