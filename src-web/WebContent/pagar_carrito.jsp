<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.DAO.ManipularCarritoDAO" import="model.VO.UsuarioVO" import="java.text.DecimalFormat" import="java.text.NumberFormat"%>
<!-------------------------------------------------------------------------------------------- 
|	Pantalla para realizar el pago de la compra.                                             |
|	En este proyecto no hemos tenido en cuenta los datos de la tarjeta ni del paypal,        |
|   puesto que son un tema de realizar una compra. Es así que esos datos no los traramos     |
--------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/styles.css">
    <script>
        // Confirmar si quieres cancelar la compra y volver a la pagina principal
        function confirmarCancelacion() {
            var confirmacion = confirm("¿Estás seguro de que quieres cancelar la compra?");
            if (confirmacion) {
                alert("Compra cancelada."); // Puedes personalizar este mensaje según tus necesidades
                window.location.href = "pantallaPrincipal.jsp"; // Redirige si se confirma
            }
        }
        
        // Dependiendo del tipo de pago muestra un formulario u otro
        function mostrarFormulario(opcion) {
            var formularioTarjeta = document.getElementById('formularioTarjeta');
            var formularioPayPal = document.getElementById('formularioPayPal');

            if (opcion === 'tarjeta') {
                formularioTarjeta.style.display = 'block';
                formularioPayPal.style.display = 'none';
            } else if (opcion === 'paypal') {
                formularioTarjeta.style.display = 'none';
                formularioPayPal.style.display = 'block';
            }
        }
    </script>
</head>
<body>
 	<div class="indiceCarrito">
 		<h2>Carrito de compra</h2>
 		<h2 class="medio">Datos envío</h2>
 		<h1>Método pago</h1>
 	</div>
 	
 	<hr class="linea">
 	<% 
 	UsuarioVO cliente = (UsuarioVO) session.getAttribute("cliente");
	if (cliente == null) {
		request.setAttribute("error", "Sesión caducada");
		request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
	}
	ManipularCarritoDAO dao = new ManipularCarritoDAO();
	float precioTotal = (float)dao.sumaPrecioCarrito(cliente.getCorreoElectronico());
	DecimalFormat df = new DecimalFormat("#.00");
	String precioFormateado = df.format(precioTotal);
	
	%>
 	<div class="container">
 		<p><b>Cantidad a pagar:</b> <%= precioFormateado %> €</p>
 	</div>
    
    <!-- Elegir un metodo de pago -->
    <form class="elegirPago">
        <label><input type="radio" name="metodoPago" value="tarjeta" onclick="mostrarFormulario('tarjeta')"> Tarjeta de Crédito</label>
        <label><input type="radio" name="metodoPago" value="paypal" onclick="mostrarFormulario('paypal')"> PayPal</label>
    </form>

    <!-- Formulario pago con tarjeta -->
    <div class="container" id="formularioTarjeta" style="display: none;">
        <h2>Pago con Tarjeta de Crédito</h2>
        <form action="SvProcesarCompra" method="post">
            <!-- Campos para la información de la tarjeta -->
            <label>Número de Tarjeta: <input type="number" name="numeroTarjeta" required></label><br>
            <label>Fecha de Vencimiento: <input type="date" name="fechaVencimiento" required></label><br>
            <label>CVV: <input type="number" name="cvv" required></label><br>
            <input class="comprar" type="submit" value="Pagar con Tarjeta">
        </form>
    </div>

    <!-- Formulario pago con paypal -->
    <div class="container" id="formularioPayPal" style="display: none;">
        <h2>Pago con PayPal</h2>
        <form action="SvProcesarCompra" method="post">
            <!-- Campos específicos de PayPal si es necesario -->
            <label>Usuario: <input type="text" name="nombreUsuario" required></label><br>
            <label>Correo Electrónico: <input type="email" name="email" required></label><br>
            <label>Contraseña: <input type="password" name="password" required></label><br>
            <input class="comprar" type="submit" value="Pagar con PayPal">
        </form>
    </div>
    
    <br><br>
     <div class="botones">
        <a href="direccion_compra.jsp" class="ant">Anterior</a>
        <a href="#" onclick="confirmarCancelacion()" class="cancelar">Cancelar</a>     
    </div>
</body>
</html>