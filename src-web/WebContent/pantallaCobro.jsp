<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.VO.ProductoVO" %>
<!DOCTYPE html>
<html>

<head>
    <title>FGP SISHAS</title>
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
    <%
    	ProductoVO producto = (ProductoVO) request.getAttribute("producto");
    %>
    <h2>Ha decidido aceptar la venta de su  <%=producto.getNombreTipoProducto()%>, introduzca sus datos para poder entregarle el dinero acordado</h2>

    <h3>Se le abonarán <%=producto.getPrecioVenta()%> euros, elija el método que prefiera: </h3>

    
    <!-- Elegir un metodo de pago -->
    <form class="elegirPago">
        <label><input type="radio" name="metodoPago" value="tarjeta" onclick="mostrarFormulario('tarjeta')"> Tarjeta de Crédito</label>
        <label><input type="radio" name="metodoPago" value="paypal" onclick="mostrarFormulario('paypal')"> PayPal</label>
    </form>

    <!-- Formulario pago con tarjeta -->
    <div class="container" id="formularioTarjeta" style="display: none;">
        <h2>Tarjeta de Crédito</h2>
        <form method="post">
            <!-- Campos para la información de la tarjeta -->
            <label>Número de Tarjeta: <input type="number" name="numeroTarjeta" required></label><br>
            <label>Fecha de Vencimiento: <input type="date" name="fechaVencimiento" required></label><br>
            <label>CVV: <input type="number" name="cvv" required></label><br>
        </form>
    </div>

    <!-- Formulario pago con paypal -->
    <div class="container" id="formularioPayPal" style="display: none;">
        <h2>Pago con PayPal</h2>
        <form method="post">
            <!-- Campos específicos de PayPal si es necesario -->
            <label>Usuario: <input type="text" name="nombreUsuario" required></label><br>
            <label>Correo Electrónico: <input type="email" name="email" required></label><br>
            <label>Contraseña: <input type="password" name="password" required></label><br>
        </form>
    </div>

    <br><br>

    <div class="botones">
       <a href="pantallaListadoVentas.jsp" class="sig">Continuar</a>  <br><br><br>
   </div>
        
</body>
</html>