package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularProductoDAO;

/**
 * Servlet implementation class SvRechazarCompra
 * Rechaza una venta que propone el cliente al administrador
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvRechazarCompra")
public class SvRechazarCompra extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvRechazarCompra() {
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
	    
	    // Obtener idProducto
	 	int idProducto =  Integer.parseInt(request.getParameter("rechazar"));
	    dao.modificarEstadoVenta(idProducto, "Rechazado", 0);

	    request.setAttribute("mensaje", "Se ha rechazado el producto con exito");
	    request.getRequestDispatcher("pantallasPropuestasComprar.jsp").forward(request, response);
	}

}
