package servlet.vender;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularProductoDAO;
import model.VO.ProductoVO;

/**
 * Servlet implementation class SvAceptarPrecio
 */
@WebServlet("/SvAceptarPrecio")
public class SvAceptarPrecio extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvAceptarPrecio() {
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
	    ProductoVO producto = dao.datosProducto(idProducto);
		float precio = producto.getPrecioVenta();
	    dao.modificarEstadoVenta(idProducto, "Vendido", precio);

        // Lo guarda y pasa a la pantalla de eleccion				
		request.setAttribute("producto", producto);
		request.getRequestDispatcher("pantallaCobro.jsp").forward(request, response);
	}

}
