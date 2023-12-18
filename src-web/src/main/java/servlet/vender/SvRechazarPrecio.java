package servlet.vender;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularProductoDAO;

/**
 * Servlet implementation class SvRechazarPrecio
 */
@WebServlet("/SvRechazarPrecio")
public class SvRechazarPrecio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvRechazarPrecio() {
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
	    int idProducto = Integer.parseInt(request.getParameter("producto"));
		dao.modificarEstadoVenta(idProducto, "Rechazado", 0);

		request.setAttribute("mensaje", "Se ha rechazado la oferta con exito");
		request.getRequestDispatcher("pantallaListadoVentas.jsp").forward(request, response);
	}

}
