package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularUsuarioDAO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvRegistrarAdmin
 * Registra un administrador
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvRegistrarAdmin")
public class SvRegistrarAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvRegistrarAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("registrarAdmin.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		ManipularUsuarioDAO dao = new ManipularUsuarioDAO();
		UsuarioVO admin = new UsuarioVO(request.getParameter("email"), request.getParameter("nombre"), request.getParameter("apellidos"), 
										request.getParameter("pwd"), false);

		boolean adminInsertado = dao.insertarUsuario(admin, true);
		if (adminInsertado) {    // Admin insertado en base datos
			request.setAttribute("mensaje", "Administrador registrado correctamente");
			request.getRequestDispatcher("pantallaPrincipalAdmin.jsp").forward(request, response);
		} else {     // ERROR - Ya existe admin
			request.setAttribute("error", "Usuario ya registrado");
			request.getRequestDispatcher("registrarAdmin.jsp").forward(request, response);
		}
	}
}
