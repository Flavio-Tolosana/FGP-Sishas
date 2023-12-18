<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="model.DAO.ManipularProductoDAO" import="model.VO.ProductoVO" import="model.VO.UsuarioVO" import="java.util.HashSet" import="java.util.Set" %>
<!-- Muestra la informacion del producto del cliente que se ha seleccionado en PantallaPrincipalAdmin.jsp y se puede eliminar o añadir unidades al producto. -->
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
    
    <!-- Extraer el producto seleccionado -->
    <% 
	int idProducto =  Integer.parseInt(request.getParameter("idProducto"));
    // Genera el productoVO a traves del dao
    ManipularProductoDAO dao = new ManipularProductoDAO();
    ProductoVO producto = dao.datosProducto(idProducto);
    String valorAtributoExtra = dao.valorAtributoExtra(producto.getIdProducto(), producto.getTipoProducto());
    %>

    <h1>Información <%=producto.getNombre()%></h1>

    <!-- Div que contiene La informacion del producto -->
    <div class="container_informacion">            
        <p>
            <b>Nombre del producto:</b>    <%=producto.getNombre()%> <br> 
            <b>Marca del producto:</b>      <%=producto.getMarca()%> <br>
            <b>Color del producto:</b>      <%=producto.getColor()%> <br>
            <b>Tipo del producto:</b>       <%=producto.getNombreTipoProducto()%> <br>
            <b>Usuario Vendedor:</b>       <%=producto.getUsuarioVendedorProducto()%> <br>
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
    </div><br><br><br><br>
    
    <!-- Formulario para eliminar un producto -->
    <form action = "SvEliminarProducto" method = "post">
        <!-- Div que contiene el boton de enviar -->
        <div class="eliminarProducto">    
            <button type="submit" class="eliminarCarrito" name="eliminar" value="<%=producto.getIdProducto()%>">Eliminar Producto</button>
        </div>
    </form>

    <!-- Formulario para añadir unidades -->
    <form action = "SvAgnadirUnidades" method = "post">
        <p>Unidades actuales del producto: <b><%=producto.getUnidades()%></b></p>
        <label for="unidades">Unidades a añadir:</label>
        <input type="number" id="unidades" name="unidades" min="1"  required /><br><br>                                        
        
        <div class="aceptar_oferta">    
            <button class="verAdmin" type="submit" name="agnadir" value="<%=producto.getIdProducto()%>">Añadir unidades producto</button>
        </div>
    </form>
    
    <!-- Formulario para modificar precio -->
    <form action = "SvModificarPrecio" method = "post">
        <p>Precio actual del producto: <b><%=producto.getPrecio()%></b></p>
        <label for="precio">Precio nuevo:</label>
        <input type="number" step="any" id="precio" name="precio" min="0"  required /><br><br>                                           
        
        <div class="aceptar_oferta">    
            <button class="verAdmin" type="submit" name="agnadir" value="<%=producto.getIdProducto()%>">Modificar precio producto</button>
        </div>
    </form>
    <br><br>
    
    <div class="botones">
		<a href="pantallaPrincipalAdmin.jsp" class="return">Volver pantalla principal</a><br><br><br>
	</div>
</body>
</html>