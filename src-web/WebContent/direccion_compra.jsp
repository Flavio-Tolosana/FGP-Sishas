<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="model.VO.UsuarioVO"%>

<!-------------------------------------------------------------------------------------------- 
|	Pantalla para meter dirección para realizar la compra. Datos autocompletados,            |
|   menso el de ciudad.                                                                      |
|	En este proyecto no hemos tenido en cuenta estos datos, puesto que serían un tema de     |
|   realizar una compra. Es así el formulario no tiene ni acción ni método                   |
--------------------------------------------------------------------------------------------->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<script>
		// Confirmas si quieres cancelar la compra y volver a la pantalla principal
		function confirmarCancelacion() {
			var confirmacion = confirm("¿Estás seguro de que quieres cancelar la compra?");
			if (confirmacion) {
				alert("Compra cancelada."); // Puedes personalizar este mensaje según tus necesidades
				window.location.href = "pantallaPrincipal.jsp"; // Redirige si se confirma
			}
		}
	</script>
</head>
<body>
	<div class="indiceCarrito">
		<h2>Carrito de compra</h2>
		<h1 class="medio">Datos envío</h1>
		<h2>Método pago</h2>
	</div>
	<hr class="linea">
       		
	<div class="container">
		<% 
			UsuarioVO cliente = (UsuarioVO) session.getAttribute("cliente");
			if (cliente == null) {
				request.setAttribute("error", "Sesión caducada");
				request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
			} 
		%>
		<!-- Formulario de direccion de compra -->
		<form>
			<label class="dir" for="nombre">Nombre:</label>
			<input class="dir" type="text" id="nombre" name="nombre" value="<%= cliente.getNombre() %>" required><br>

			<label class="dir" for="apellidos">Apellidos:</label>
			<input class="dir" type="text" id="apellidos" name="apellidos" value="<%= cliente.getApellidos() %>" required><br>

			<label class="dir" for="calle">Calle:</label>
			<input class="dir" type="text" id="calle" name="calle" value="<%= cliente.getCalle() %>" required><br>

			<label class="dir" for="pisoPuerta">Piso y Puerta:</label>
			<input class="dir" type="text" id="pisoPuerta" name="pisoPuerta" value="<%= cliente.getPisoPuerta() %>" required><br>

			<label class="dir" for="codigoPotal">Codigo Postal:</label>
			<input class="dir" type="text" id="codigoPostal" name="codigoPostal" value="<%= cliente.getCodigoPostal() %>" required><br>

			<label class="dir" for="provincia">Selecciona una provincia:</label>
			<select required name="provincia" class="dir" required>
				<option value="Álava/Araba">Álava/Araba</option>
				<option value="Albacete">Albacete</option>
				<option value="Alicante">Alicante</option>
				<option value="Almería">Almería</option>
				<option value="Asturias">Asturias</option>
				<option value="Ávila">Ávila</option>
				<option value="Badajoz">Badajoz</option>
				<option value="Baleares">Baleares</option>
				<option value="Barcelona">Barcelona</option>
				<option value="Burgos">Burgos</option>
				<option value="Cáceres">Cáceres</option>
				<option value="Cádiz">Cádiz</option>
				<option value="Cantabria">Cantabria</option>
				<option value="Castellón">Castellón</option>
				<option value="Ceuta">Ceuta</option>
				<option value="Ciudad Real">Ciudad Real</option>
				<option value="Córdoba">Córdoba</option>
				<option value="Cuenca">Cuenca</option>
				<option value="Gerona/Girona">Gerona/Girona</option>
				<option value="Granada">Granada</option>
				<option value="Guadalajara">Guadalajara</option>
				<option value="Guipúzcoa/Gipuzkoa">Guipúzcoa/Gipuzkoa</option>
				<option value="Huelva">Huelva</option>
				<option value="Huesca">Huesca</option>
				<option value="Jaén">Jaén</option>
				<option value="La Coruña/A Coruña">La Coruña/A Coruña</option>
				<option value="La Rioja">La Rioja</option>
				<option value="Las Palmas">Las Palmas</option>
				<option value="León">León</option>
				<option value="Lérida/Lleida">Lérida/Lleida</option>
				<option value="Lugo">Lugo</option>
				<option value="Madrid">Madrid</option>
				<option value="Málaga">Málaga</option>
				<option value="Melilla">Melilla</option>
				<option value="Murcia">Murcia</option>
				<option value="Navarra">Navarra</option>
				<option value="Orense/Ourense">Orense/Ourense</option>
				<option value="Palencia">Palencia</option>
				<option value="Pontevedra">Pontevedra</option>
				<option value="Salamanca">Salamanca</option>
				<option value="Segovia">Segovia</option>
				<option value="Sevilla">Sevilla</option>
				<option value="Soria">Soria</option>
				<option value="Tarragona">Tarragona</option>
				<option value="Tenerife">Tenerife</option>
				<option value="Teruel">Teruel</option>
				<option value="Toledo">Toledo</option>
				<option value="Valencia">Valencia</option>
				<option value="Valladolid">Valladolid</option>
				<option value="Vizcaya/Bizkaia">Vizcaya/Bizkaia</option>
				<option value="Zamora">Zamora</option>
				<option value="Zaragoza">Zaragoza</option>
			</select><br>
				
			<label class="dir" for="ciudad">Ciudad:</label>
			<input class="dir" type="text" id="ciudad" name="ciudad" required><br>

			<label class="dir" for="telefono">Teléfono:</label>
			<input class="dir" type="tel" id="telefono" name="telefono" pattern="[0-9]{9}" value="<%= cliente.getNumeroTelefono() %>" required><br>
		</form>
	</div><br>
    <div class="botones">
	    <a href="carrito.jsp" class="ant">Anterior</a>
	    <!-- Al darle a siguiente no procesamos los datos -->
	    <a href="pagar_carrito.jsp" class="sig">Siguiente</a><br><br><br>
	    <a href="#" onclick="confirmarCancelacion()" class="cancelar">Cancelar</a>
    </div>
</body>
</html>