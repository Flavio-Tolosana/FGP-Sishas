package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularProductoDAO;

/**
 * Servlet implementation class SvAceptarCompra
 * Acepta una venta que propone el cliente al administrador
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvAceptarCompra")
public class SvAceptarCompra extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvAceptarCompra() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	    ManipularProductoDAO dao = new ManipularProductoDAO();

	    // Obtener idProducto y precio
	 	int idProducto =  Integer.parseInt(request.getParameter("aceptar"));
	 	float precioOferta = Float.parseFloat(request.getParameter("precio"));
	 	
	 	// El precio del producto en la web será un 20% más que el precioOferta
	 	// Es decir, el dinero que le vas a dar al usuario que ha vendido el producto es precioOferta
	 	// Y el precio con el que se va a vender en la web es un 20% más que ese precioOferta
	 	float beneficio = (precioOferta * 20) / 100;
	 	float precio = precioOferta + beneficio;
	 	dao.modificarPrecioProducto(idProducto, precio);
	    dao.modificarEstadoVenta(idProducto, "Oferta", precioOferta);
	   
	    request.setAttribute("mensaje", "Se ha realizado la oferta con exito");
	    request.getRequestDispatcher("pantallasPropuestasComprar.jsp").forward(request, response); 
	}

}
