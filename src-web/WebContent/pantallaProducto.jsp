<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set" %>
    

<!-- Muestra la informacion del producto del cliente que se ha seleccionado en PantallaPropuestaComprar.jsp y se puede aceptar o rechazar producto. -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FGP SISHAS</title>
    <link rel="stylesheet" href="css/agnadirProductoStyle.css">
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
    
    <!-- Extraer el producto seleccionado -->
    <% 
		int idProducto = (int)request.getAttribute("idProducto");
	    // Genera el productoVO a traves del dao
	    ManipularProductoDAO dao = new ManipularProductoDAO();
	    ProductoVO producto = dao.datosProducto(idProducto);
        String valorAtributoExtra = dao.valorAtributoExtra(producto.getIdProducto(), producto.getTipoProducto());
    %>

    <!-- Div que contiene La informacion del producto -->
    <div class="container_informacion">            
        <p>
            <b>Nombre del producto:</b>    <%=producto.getNombre()%> <br> 
            <b>Marca del producto:</b>      <%=producto.getMarca()%> <br>
            <b>Color del producto:</b>      <%=producto.getColor()%> <br>
            <b>Precio del producto:</b>      <%=producto.getPrecio()%> <br>
            <b>Tipo del producto:</b>       <%=producto.getNombreTipoProducto()%> <br>
            <b>Estado del producto:</b>     <%=producto.getEstadoProducto() %>
        </p> 

		<!-- Dependiendo del tipo producto se muestra un mensaje u otro  -->
        <%  if (producto.getNombreTipoProducto().equals("accesorio")){
            %>
                <div class = "atributoExtra">
                    <p>
                        <b>Tipo de accesorio:</b>  <%=valorAtributoExtra%>
                    </p>
                </div>
        <%    } else if (producto.getNombreTipoProducto().equals("mastil")){
            %>
            <div class = "atributoExtra">
                <p>
                    <b>Encaje en cm:</b>  <%=valorAtributoExtra%>
                </p>
            </div>        
        <%    } else if (producto.getNombreTipoProducto().equals("cachimba")){
            %>
            <div class = "atributoExtra">
                <p>
                    <b>Altura en cm:</b>  <%=valorAtributoExtra%>
                </p>
            </div>
        <%    } else if (producto.getNombreTipoProducto().equals("cazoleta")){
            %>
            <div class = "atributoExtra">
                <p>
                    <b>Tipo de cazoleta:</b>  <%=valorAtributoExtra%>
                </p>
            </div>
        <%    } else if (producto.getNombreTipoProducto().equals("manguera")){
            %>
            <div class = "atributoExtra">
                <p>
                    <b>Largura en cm:</b>  <%=valorAtributoExtra%>
                </p>
            </div>
        <%    } else if (producto.getNombreTipoProducto().equals("base")){
            %>
            <div class = "atributoExtra">
                <p>
                    <b>Encaje en cm:</b>  <%=valorAtributoExtra%>
                </p>
            </div>
        <%    }
        %>
    </div>

    <!-- Div que contiene unicamente la imagen del producto -->
    <div class="container-image">            
        <img alt="Imagen del producto" src=<%=producto.getUrlFoto()%>>
    </div><br><br><br><br><br>
    
    <% if (producto.getUnidades() > 0) {%>    
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
    <%} %>
    <br><br>
    <div class="botones">
		<a href="pantallaPrincipal.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>