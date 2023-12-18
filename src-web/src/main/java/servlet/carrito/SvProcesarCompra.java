package servlet.carrito;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import model.DAO.ManipularCarritoDAO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvProcesarCompra
 * Realiza una compra. Borra el carrito del usuario y lo mete en la tabla compras
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvProcesarCompra")
public class SvProcesarCompra extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvProcesarCompra() {
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

		// Si es posible realizar la compra
		if (dao.posibleRealizarCompra(cliente.getCorreoElectronico())) {
			
			LocalDateTime fechaHoraActual = LocalDateTime.now();
	        DateTimeFormatter formato = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm:ss");
	        String tiempoCompra = fechaHoraActual.format(formato);
			dao.realizarCompra(cliente.getCorreoElectronico(), tiempoCompra);
			request.setAttribute("mensaje", "Compra realizada con éxito");
			request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
		}
		else {   // No es posible realizar la compra
			request.setAttribute("error", "No se ha podido realizar compra. Falta stock de algunos productos.");
			request.getRequestDispatcher("carrito.jsp").forward(request, response);
		}
	}
}
