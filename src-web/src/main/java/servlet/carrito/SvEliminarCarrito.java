package servlet.carrito;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO.ManipularCarritoDAO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvEliminarCarrito
 * Elimina un producto del carrito de un usuario
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvEliminarCarrito")
public class SvEliminarCarrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvEliminarCarrito() {
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

		HttpSession session = request.getSession();
		UsuarioVO cliente = (UsuarioVO) session.getAttribute("cliente");
		if (cliente == null) {
			request.setAttribute("error", "Sesión caducada");
			request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
		}
		int idProducto =  Integer.parseInt(request.getParameter("eliminarCarrito"));
		ManipularCarritoDAO dao = new ManipularCarritoDAO();

		// Eliminar producto del carrito
		dao.eliminarProductoCarrito(cliente.getCorreoElectronico(), idProducto);
		request.setAttribute("mensaje", "Producto eliminado del carrito");
		request.getRequestDispatcher("carrito.jsp").forward(request, response);
	}

}
