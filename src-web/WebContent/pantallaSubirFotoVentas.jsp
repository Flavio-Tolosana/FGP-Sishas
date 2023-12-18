<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FGP SISHAS</title>
	<link rel="stylesheet" href="css/agnadirProductoStyle.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
	<link rel="stylesheet" href="css/styles.css">
	<script>
	    function previewImage(event) {
	      const input = event.target;
	      const preview = document.getElementById('preview');
	      
	      if (input.files && input.files[0]) {
	        const reader = new FileReader();
	    
	        reader.onload = function(e) {
	          preview.src = e.target.result;
	          preview.style.display = 'block';
	        }
	    
	        reader.readAsDataURL(input.files[0]);
	      }
	    }
	    
    </script>
</head>
<body>

    <h1>Seleccione la foto del pruducto que desea vender:</h1>
    <form action = "SvSubirFotoVender" method = "post" enctype="multipart/form-data">

		<!-- Div que contiene unicamente la imagen del producto -->
        <div class="container_informacion">            
            <p>
                Añada una imagen del producto: 
                <input type="file" id="inputFile" accept="image/*" onchange="previewImage(event)" name="imagen"/>
                <img id="preview" src="#" alt="Vista previa de la imagen" style="display: none; max-width: 200px; max-height: 200px;" />
            </p>         
        </div>

        <div>
            <p>
                Nuestros trabajadores revisarán el producto y le comunicarán una decisión en un plazo de 5 días laborables.
            </p>
            <p>
                Si nos interesa le enviaran una oferta, en caso contrario se reschazará el producto.
            </p>
        </div>
        <!-- Div que contiene el boton de enviar -->
        <div class="enviar_informacion">    
                <button type="submit" id="boton-vender" name="subirFoto" value="<%=request.getAttribute("idProducto")%>">Subir foto</button>       
        </div>
    </form>
</body>
</html>