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
    <h1>Aceptar o Rechazar producto</h1>
    
    <!-- Extraer el producto seleccionado -->
    <% 
        ManipularProductoDAO dao = new ManipularProductoDAO();
        ProductoVO producto = (ProductoVO) request.getAttribute("producto");
        String valorAtributoExtra = dao.valorAtributoExtra(producto.getIdProducto(), producto.getTipoProducto());
    %>

    <!-- Div que contiene La informacion del producto -->
    <div class="container_informacion">            
        <p>
            <b>Nombre del producto:</b>    <%=producto.getNombre()%> <br> 
            <b>Marca del producto:</b>      <%=producto.getMarca()%> <br>
            <b>Color del producto:</b>      <%=producto.getColor()%> <br>
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
    
    <!-- Rechazar compra -->
    <form action = "SvRechazarCompra" method = "post">
        <div class="rechazar_oferta">    
            <button type="submit" class="eliminarCarrito" name="rechazar" value="<%=producto.getIdProducto()%>">Rechazar</button>
        </div>
    </form>

    <!-- Aceptar compra -->
    <form action = "SvAceptarCompra" method = "post">

        <label for="precio">Precio a ofertar:</label>
        <input type="number" id="precio" name="precio" step="any" min="0"  required /><br><br>    
                                            
        <div class="aceptar_oferta">    
            <button type="submit" class="verAdmin" name="aceptar" value="<%=producto.getIdProducto()%>">Aceptar</button>
        </div>
    </form>
    <br><br>
    <div class="botones">
		<a href="pantallasPropuestasComprar.jsp" class="return">Volver pantalla propuestas comprar</a><br><br><br>
	</div>
    
</body>
</html>