
document.addEventListener("DOMContentLoaded", function() {
	
	// Obtén una referencia al elemento select
	var tipoProductoSelect = document.getElementById("tipoProducto");
	
	// Obtén referencias a los divs que deseas mostrar/ocultar
	var divAccesorio = document.querySelector(".atributo_extra_Accesorio");
	var divMastil = document.querySelector(".atributo_extra_Mastil");
	var divCachimbaCompleta = document.querySelector(".atributo_extra_Cachimba-completa");
	var divCazoleta = document.querySelector(".atributo_extra_Cazoleta");
	var divMangueras = document.querySelector(".atributo_extra_Mangueras");
	var divBase = document.querySelector(".atributo_extra_Base");
	
	
	
	// Agrega un evento de cambio al select
	tipoProductoSelect.addEventListener("change", function() {
	    // Oculta todos los divs
	    divAccesorio.style.display = "none";
	    divMastil.style.display = "none";
	    divCachimbaCompleta.style.display = "none";
	    divCazoleta.style.display = "none";
	    divMangueras.style.display = "none";
	    divBase.style.display = "none";
	
	    // Muestra el div correspondiente al tipo de producto seleccionado
	    var selectedOption = tipoProductoSelect.options[tipoProductoSelect.selectedIndex].value;
	    if (selectedOption === "accesorio") {
	        divAccesorio.style.display = "block";
	        document.getElementById("boton-vender").value = "accesorio";
	    } else if (selectedOption === "mastil") {
	        divMastil.style.display = "block";
	        document.getElementById("boton-vender").value = "mastil";
	    } else if (selectedOption === "cachimba") {
	        divCachimbaCompleta.style.display = "block";
	        document.getElementById("boton-vender").value = "cachimba";
	    } else if (selectedOption === "cazoleta") {
	        divCazoleta.style.display = "block";
	        document.getElementById("boton-vender").value = "cazoleta";
	    } else if (selectedOption === "manguera") {
	        divMangueras.style.display = "block";
	        document.getElementById("boton-vender").value = "manguera";
	    } else if (selectedOption === "base") {
	        divBase.style.display = "block";
	        document.getElementById("boton-vender").value = "base";
	    }
	});    
});  
