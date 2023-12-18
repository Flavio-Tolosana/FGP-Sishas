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
 * Inicia la sesión de un administrador
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvIniciarSesionAdmin")
public class SvIniciarSesionAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvIniciarSesionAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("iniciarSesionAdmin.jsp").forward(request, response);
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

		boolean existeAdmin = dao.existeUsuario(email, true);
		if (existeAdmin) {    // Existe el administrador
			boolean valido = dao.validarUsuario(email, contrasegna, true);
			if (valido) {      // El administrador ha introducido credenciales correctas
				UsuarioVO admin = dao.obtenerUsuario(email);
				session.setAttribute("admin", admin);
				request.getRequestDispatcher("pantallaPrincipalAdmin.jsp").forward(request, response);
			} else {      // El administrador no ha introducido bien credenciales
				request.setAttribute("error", "Contraseña Incorrecta");
				request.getRequestDispatcher("iniciarSesionAdmin.jsp").forward(request, response);
			}
		} else {     // No existe administrador
			request.setAttribute("error", "Administrador no registrado");
			request.getRequestDispatcher("iniciarSesionAdmin.jsp").forward(request, response);
		}
	}
}
