<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.VO.UsuarioVO" import="model.DAO.ManipularCompraDAO" import="model.VO.ComprasVO" 
import="model.DAO.ManipularCompraDAO" import="java.util.HashSet" import="java.util.Set" import="java.text.DecimalFormat" import="java.text.NumberFormat"%>
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
	<h1>Historial de compras</h1>
	<div class="products">
		<% // Obtener productos de Primera Mano
			ManipularCompraDAO dao = new ManipularCompraDAO();
			Set<String> listaTiemposCompra = dao.listaCompras(cliente.getCorreoElectronico());
			if (listaTiemposCompra.isEmpty()) {   // No hay productos
		%>
			<div class="error">
				<p style="text-align: center;">No se han realizado ninguna compra</p>
			</div>
		<%
			}
			else {   // Iterar para obtener los productos
				for (String tiempoCompra : listaTiemposCompra) {
		%>
		<!-- Cada compra en una fecha -->
		<div class="product">
			<table>
				<tr>
					<td><b class="label">Fecha compra:</b></td>  
					<td><%= tiempoCompra%></td>
				<tr>
					<td><b class="label">Precio compra:</b></td>
					<%
					float precioTotal = (float)dao.sumaPrecioCompra(cliente.getCorreoElectronico(), tiempoCompra);
					DecimalFormat df = new DecimalFormat("#.00");
					String precioFormateado = df.format(precioTotal); 
					%>
					<td><%=precioFormateado%> €</td>
				</tr>
			</table><br>
			<!-- Enlace info compra -->
				<div class="formulario-carrito">
					<a href="infoCompra.jsp?tiempoCompra=<%=tiempoCompra%>" class="update-carrito">Ver información compra</a>
				</div>
		</div>	
		<%
			}
		}
		%>
	</div>
	<div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>