<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="java.util.HashSet" import="java.util.Set" import="model.VO.UsuarioVO"%>
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
	</script>
</head>
<body>
	<!-- Cabecera donde aparece la inforamación del usuario -->
    <div class="header">
    	<div class="info_cliente">
    	<%
    	ManipularProductoDAO dao = new ManipularProductoDAO();
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

	<div class="explicacion">
		<h2>¿Cómo montar una cachimba?</h2>
		<h3>Seleccione un producto que le interese, en ese momento se añadirá en el apartado de productos seleccionados y solo se mostrarán los productos compatibles al elemento seleccionado. Una vez seleccionados los productos deseados, pulse el botón de añadir al carrito.</h3><br>
	</div>

	<h2>Productos seleccionados</h2>
	<div class="products">
		<%
		int base = 0;
		if (request.getAttribute("base") != null) {
			base = (int)request.getAttribute("base");
		}
		int mastil = 0;
		if (request.getAttribute("mastil") != null) {
			mastil = (int)request.getAttribute("mastil");
		}
		int manguera = 0;
		if (request.getAttribute("manguera") != null) {
			manguera = (int)request.getAttribute("manguera");
		}
		int cazoleta = 0;
		if (request.getAttribute("cazoleta") != null) {
			cazoleta = (int)request.getAttribute("cazoleta");
		}
		String encaje = "0";
		if (request.getAttribute("encaje") != null) {
			encaje = (String)request.getAttribute("encaje");
		}

		if (base == 0){
			%>
			<!-- Base no seleccionada -->
			<div class="seleccionado">
				<h3>Ninguna base seleccionada</h3>
			</div>
			<%
		} else {
			ProductoVO producto = dao.datosProducto(base);
			%>
			<!-- base seleccionada -->
			<div class="seleccionado">
				<h3>Base seleccionado</h3>
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
				</table><br>
				<form action="SvEliminarMontarCachimba" method="post">
					<div class="formulario-montar-cachimba">

						<input type="hidden" name="base" value="<%= base %>">
						<input type="hidden" name="mastil" value="<%= mastil %>">
						<input type="hidden" name="manguera" value="<%= manguera %>">
						<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
						<input type="hidden" name="encaje" value="<%= encaje %>">

						<button class="eliminarCarrito" type="submit" name="ProductoSeleccionado" value="<%=base%>">
							Eliminar
						</button>
					</div>
				</form>
			</div>
			
			<%
		}

		if (mastil == 0){
			%>
			<!-- Mastil no seleccionada -->
			<div class="seleccionado">
				<h3>Ningun mastil seleccionado</h3>
			</div>
			<%
		} else {
			ProductoVO producto = dao.datosProducto(mastil);
			%>
			<!-- Mastil seleccionada -->
			<div class="seleccionado">
				<h3>Mastil seleccionado</h3>
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
				</table><br>
				<form action="SvEliminarMontarCachimba" method="post">
					<div class="formulario-montar-cachimba">

						<input type="hidden" name="base" value="<%= base %>">
						<input type="hidden" name="mastil" value="<%= mastil %>">
						<input type="hidden" name="manguera" value="<%= manguera %>">
						<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
						<input type="hidden" name="encaje" value="<%= encaje %>">

						<button class="eliminarCarrito" type="submit" name="ProductoSeleccionado" value="<%=mastil%>">
							Eliminar
						</button>
					</div>
				</form>
			</div>
			<%
		}

		if (manguera == 0){
			%>
			<!-- Mangueras no seleccionada -->
			<div class="seleccionado">
				<h3>Ninguna manguera seleccionada</h3>
			</div>
			<%
		} else {
			ProductoVO producto = dao.datosProducto(manguera);
			%>
			<!-- Manguera seleccionada -->
			<div class="seleccionado">
				<h3>Mangueras seleccionadas</h3>
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
				</table><br>
				<form action="SvEliminarMontarCachimba" method="post">
					<div class="formulario-montar-cachimba">

						<input type="hidden" name="base" value="<%= base %>">
						<input type="hidden" name="mastil" value="<%= mastil %>">
						<input type="hidden" name="manguera" value="<%= manguera %>">
						<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
						<input type="hidden" name="encaje" value="<%= encaje %>">

						<button class="eliminarCarrito" type="submit" name="ProductoSeleccionado" value="<%=manguera%>">
							Eliminar
						</button>
					</div>
				</form>
			</div>
			<%
		}

		if (cazoleta == 0){
			%>
			<!-- Cazoleta no seleccionada -->
			<div class="seleccionado">
				<h3>Ninguna cazoleta seleccionada</h3>
			</div>
			<%
		} else {
			ProductoVO producto = dao.datosProducto(cazoleta);
			%>
			<!-- Cazoleta seleccionada -->
			<div class="seleccionado">
				<h3>Cazoleta seleccionada</h3>
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
				</table><br>
				<form action="SvEliminarMontarCachimba" method="post">
					<div class="formulario-montar-cachimba">

						<input type="hidden" name="base" value="<%= base %>">
						<input type="hidden" name="mastil" value="<%= mastil %>">
						<input type="hidden" name="manguera" value="<%= manguera %>">
						<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
						<input type="hidden" name="encaje" value="<%= encaje %>">

						<button class="eliminarCarrito" type="submit" name="ProductoSeleccionado" value="<%=cazoleta%>">
							Eliminar
						</button>
					</div>
				</form>
			</div>
			<%
		}
		%>
	</div>

	<form action="SvAgnadirMontarCachimbaCarrito" method="post">
		<div class="formulario-montar-cachimba-carrito">
			<input type="hidden" name="base" value="<%= base %>">
			<input type="hidden" name="mastil" value="<%= mastil %>">
			<input type="hidden" name="manguera" value="<%= manguera %>">
			<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
			<input type="hidden" name="encaje" value="<%= encaje %>">

			<button type="submit" name="addCarrito" class="add-to-carrito-montar">
				<i class="fas fa-cart-plus"></i> Añadir al carrito los productos seleccionados
			</button>
		</div>
	</form>
	
	<hr class="linea">

	<%
	int tipo = 3;
	String tipoProducto = "";

	for(int i = 0; i < 4; i++){
		if (i == 0) {
			tipoProducto = "Bases";
			tipo = 3;
		}
		else if(i == 1){
			tipoProducto = "Mástiles";
			tipo = 4;
		}
		else if(i == 2){
			tipoProducto = "Mangueras";
			tipo = 1;
		}
		else if(i == 3){
			tipoProducto = "Cazoletas";
			tipo = 5;
		}
    %>

		<!-- Lista productos primera mano -->
		<h2> <%=tipoProducto%> de Primera Mano</h2>
		<div class="products">
			<% // Obtener productos de Primera Mano
				Set<ProductoVO> listaProductosPrimeraManoCategoria;
				if (i == 0 || i == 1) {  // Si es una base o un mástil 
					
					listaProductosPrimeraManoCategoria = dao.listaProductosMontar(true, "Vendido", tipo, encaje);
				} else {
					listaProductosPrimeraManoCategoria = dao.listaProductosCategoria(true, "Vendido", tipo);
				}

				
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
				<div class="formulario-montar-cachimba">
					<button class="add-to-carrito" onclick="alertaProductoAgotado()">
						Seleccionar
					</button>
				</div>
				<% } else { %>
				<form action="SvSeleccionarMontarCachimba" method="post">
					<div class="formulario-montar-cachimba">

						<input type="hidden" name="base" value="<%= base %>">
						<input type="hidden" name="mastil" value="<%= mastil %>">
						<input type="hidden" name="manguera" value="<%= manguera %>">
						<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
						<input type="hidden" name="encaje" value="<%= encaje %>">
					
						<button class="add-to-carrito" type="submit" name="ProductoSeleccionado" value="<%=producto.getIdProducto()%>">
							Seleccionar
						</button>
					</div>
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
			Set<ProductoVO> listaProductosSegundaManoCategoria;
			if (i == 0 || i == 1) {
				
				listaProductosSegundaManoCategoria = dao.listaProductosMontar(false, "Vendido", tipo, encaje);
			} else {
				listaProductosSegundaManoCategoria = dao.listaProductosCategoria(false, "Vendido", tipo);
			}
				
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
					<div class="formulario-montar-cachimba">
						<button class="add-to-carrito" onclick="alertaProductoAgotado()">
							Seleccionar
						</button>
					</div>
					<% } else { %>
					<form action="SvSeleccionarMontarCachimba" method="post">
						<div class="formulario-montar-cachimba">

							<input type="hidden" name="base" value="<%= base %>">
							<input type="hidden" name="mastil" value="<%= mastil %>">
							<input type="hidden" name="manguera" value="<%= manguera %>">
							<input type="hidden" name="cazoleta" value="<%= cazoleta %>">
							<input type="hidden" name="encaje" value="<%= encaje %>">

							<button class="add-to-carrito" type="submit" name="ProductoSeleccionado" value="<%=producto.getIdProducto()%>">
								Seleccionar
							</button>
						</div>
					</form>
				<%} %>
			</div>	
			<%
				}
			}
			%>

		</div>
		<hr class="linea">
	<%
	}		
	%>
	<br><br>
	<div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>