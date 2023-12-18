package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO.ManipularUsuarioDAO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvIniciarSesion
 * Inicia sesión de un cliente
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvIniciarSesionCliente")
public class SvIniciarSesionCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvIniciarSesionCliente() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		ManipularUsuarioDAO dao = new ManipularUsuarioDAO();
		String email = request.getParameter("email");
		String contrasegna = request.getParameter("contrasegna");
		
		boolean existeCliente = dao.existeUsuario(email, false);
		if (existeCliente) {    // Existe el cliente 
			boolean valido = dao.validarUsuario(email, contrasegna, false);
			if (valido) {      // El cliente ha introducido credenciales correctas
				UsuarioVO cliente = dao.obtenerUsuario(email);
				session.setAttribute("cliente", cliente);
				request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
			} else {      // El cliente no ha introducido bien credenciales
				request.setAttribute("error", "Contraseña Incorrecta");
				request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
			}
		} else {     // No existe cliente
			request.setAttribute("error", "Usuario no registrado");
			request.getRequestDispatcher("iniciarSesionCliente.jsp").forward(request, response);
		}
	}
}
