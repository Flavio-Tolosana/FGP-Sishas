<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="java.util.HashSet" import="java.util.Set" %>

<!----------------------------------------------------------------------------------------------------------------
|	Pagina principal del sistema información. Pero en el los usuarios están sin iniciar sesión y sin registrar.  |
|	Para poder añadir productos al carrito, montar cachimbas y vender cachimbas deben iniciar sesión.            |
|	Además los administradores pueden iniciar sesión.                                                            |
----------------------------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<script>
		// Salta mensaje si quieres iniciarSesión. Si es sí redirige alli
		function alertaNecesitaIniciarSesion(){
			var confirmacion = confirm("Necesita iniciar sesión. ¿Desea inicar sesión?");
			if (confirmacion) {
				window.location.href = "iniciarSesionCliente.jsp"; // Redirige si se confirma
			}
		}
	</script>
</head>
<body>
	<!-- Cabecera -->
    <div class="header">
        <a href="iniciarSesionAdmin.jsp">ADMIN</a>
        <a href="iniciarSesionCliente.jsp">Iniciar Sesión</a>
        <a href="registrarCliente.jsp">Registrarse</a>
    </div>
    
    <br><br>
    
    <h1>FGP SISHAS</h1>

    <br><br>

	<!-- Tipos de productos -->
    <div class="navigation">
        <button onclick="alertaNecesitaIniciarSesion()">Cachimbas</button>
        <button onclick="alertaNecesitaIniciarSesion()">Bases</button>
        <button onclick="alertaNecesitaIniciarSesion()">Mástiles</button>
        <button onclick="alertaNecesitaIniciarSesion()">Cazoletas</button>
        <button onclick="alertaNecesitaIniciarSesion()">Mangueras</button>
        <button onclick="alertaNecesitaIniciarSesion()">Accesorios</button>
    </div>

	<!-- Opciones de Montar cachimba y Vender Cachimba -->
    <div class="options">
        <div class="option1" onclick="alertaNecesitaIniciarSesion()">
            <img src="imagenes/montar_cachimba.png" alt="Monta tu propia cachimba"><br>
            <p>Monta tu propia cachimba</p>
        </div>
        <div class="option2" onclick="alertaNecesitaIniciarSesion()">
            <img src="imagenes/desea_vender.png" alt="Desea vender"><br>
            <p>Desea vender</p>
        </div>
    </div>
    
	<!-- Lista productos primera mano -->
	<h2>Productos Primera Mano</h2>
	<div class="products">
		<% // Obtener productos de Primera Mano
			ManipularProductoDAO dao = new ManipularProductoDAO();
			Set<ProductoVO> listaProductosPrimeraMano = dao.listaProductos(true, "Vendido");
			if (listaProductosPrimeraMano.isEmpty()) {  // Si no hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {   // Iterar sobre el set para obtener los productos
				for (ProductoVO producto : listaProductosPrimeraMano) {
		%>
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
			<button class="add-to-carrito" onclick="alertaNecesitaIniciarSesion()">
				<i class="fas fa-cart-plus"></i>Añadir al carrito
			</button>
		</div>	
		<%
				}
			}
		%>
	</div>

	<!-- Lista productos segunda mano -->
	<h2>Productos Segunda Mano</h2>
	<div class="products">
		
		<% // Obtener productos de Segunda Mano
			Set<ProductoVO> listaProductosSegundaMano = dao.listaProductos(false, "Vendido");
			
			if (listaProductosSegundaMano.isEmpty()) {   // Si no hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No hay productos en stock</p>
			</div>
		<%
			}
			else {    // Iterar sobre el set para obtener los productos
				for (ProductoVO producto : listaProductosSegundaMano) {
		%>
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
			<button class="add-to-carrito" onclick="alertaNecesitaIniciarSesion()">
				<i class="fas fa-cart-plus"></i>Añadir al carrito
			</button>
		</div>	
		<%
				}
			}
		%>
	</div>		
</body>
</html>