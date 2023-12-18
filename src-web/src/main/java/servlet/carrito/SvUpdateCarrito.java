package servlet.carrito;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO.ManipularCarritoDAO;
import model.VO.CarritoVO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvUpdateCarrito
 * Actualizar cantidad seleccionada de un producto del carrito de un cliente
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvUpdateCarrito")
public class SvUpdateCarrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvUpdateCarrito() {
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
		ManipularCarritoDAO dao = new ManipularCarritoDAO();

		int idProducto =  Integer.parseInt(request.getParameter("updateCarrito"));
		int cantidad =  Integer.parseInt(request.getParameter(request.getParameter("updateCarrito")));

		if(cantidad > 0) {  // Si la actualización del carrito es > 0
			// Actualizar carrito
			CarritoVO carrito = new CarritoVO(cliente.getCorreoElectronico(), idProducto, cantidad);
			dao.actualizarCantidadProductoCarrito(carrito);
		} else {  // Si la cantidad actualizada == 0
			dao.eliminarProductoCarrito(cliente.getCorreoElectronico(), idProducto);
		}
		
		request.setAttribute("mensaje", "Cantidad seleccionada actualizada");
		request.getRequestDispatcher("carrito.jsp").forward(request, response);
	}
}
