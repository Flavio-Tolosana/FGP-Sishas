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
    
    <!-- Opciones de Ver Propuestas y Añadir Productos -->
    <div class="options">
        <div class="option1" onclick="window.location.href='pantallasPropuestasComprar.jsp';">
            <img src="imagenes/desea_vender.png"><br>
            <p>Propuesta de compra</p>
        </div>

        <div class="option2" onclick="window.location.href='pantallaAgnadirProducto.jsp';">
            <img src="imagenes/agnadirProducto.png"><br>
            <p>Añadir producto</p>
        </div>
    </div>
	
	<!-- Mensaje producto añadido -->
    <% if (request.getAttribute("mensaje") != null) { %> 
        <div id="mensaje" class="mensaje"><%=request.getAttribute("mensaje")%></div>
		<script>
		        // Después de 6000 milisegundos (6 segundos), ocultar el mensaje
		        setTimeout(function() {
		            document.getElementById("mensaje").style.display = "none";
		        }, 6000);
		</script>
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
			<a class="ver" href="pantallaInformacionProducto.jsp?idProducto=<%=producto.getIdProducto()%>">Ver producto</a>
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
			<a class="ver" href="pantallaInformacionProducto.jsp?idProducto=<%=producto.getIdProducto()%>">Ver producto</a>
		</div>	
		<%
			}
		}
		%>
	</div>
</body>
</html>