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
 * Servlet implementation class SvAddCarrito
 * Añadir un producto al carrito
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvAddCarrito")
public class SvAddCarrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvAddCarrito() {
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
		int idProducto =  Integer.parseInt(request.getParameter("addCarrito"));
		int cantidad =  Integer.parseInt(request.getParameter(request.getParameter("addCarrito")));
		if (cantidad < 1) {
			request.setAttribute("error", "Debe seleccionar al menos 1 unidad para añadirla al carrito");
			request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
		}
		else {
			CarritoVO carrito = new CarritoVO(cliente.getCorreoElectronico(), idProducto, cantidad);
			ManipularCarritoDAO dao = new ManipularCarritoDAO();
	
			// Insertar producto en el carrito del cliente
			dao.insertarProductoCarrito(carrito);
			request.setAttribute("mensaje", "Producto Añadido al Carrito");
			request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
		}
	}
}
