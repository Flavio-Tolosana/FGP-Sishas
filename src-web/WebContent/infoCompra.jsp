<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.DAO.ManipularCompraDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set"%>

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

	<%String tiempoCompra = request.getParameter("tiempoCompra");%>
	<!-- Productos de la compra -->
	<h1>Productos de la compra del <%=tiempoCompra %></h1>

	<!-- Cada producto de la compra -->
	<div class="products">
		<%  
		ManipularCompraDAO dao = new ManipularCompraDAO();
		Set<ProductoVO> listaProductosCompra = dao.listaProductosCompra(cliente.getCorreoElectronico(), tiempoCompra);
		if (listaProductosCompra != null && listaProductosCompra.isEmpty()) {   // Carrito vacío
		%>
		<div class="error">
			<p style="text-align: center;">No hay productos en esta compra</p>
		</div>
		<% } else {   // Iterar sobre lista productos
				for (ProductoVO producto : listaProductosCompra) {%>
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
					<td><b class="label">Cantidad comprada:</b></td>    
					<td><%=producto.getUnidades() %></td>
				</tr>
				<tr>
					<td><b class="label">Tipo Producto:</b></td>    
					<td><%=producto.getNombreTipoProducto() %></td>
				</tr>
				<tr>
					<td><b class="label">Estado:</b></td>    
					<td><%=producto.getEstadoProducto() %></td>
				</tr>
			</table><br>
		</div>	
		<%
				}
			}
		%>
	</div>
	<div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
		<a href="historialCompras.jsp" class="return">Volver historial compras</a>
	</div>
</body>
</html>