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
 * Servlet implementation class SvRegistrarCliente
 * Registra a un cliente
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvRegistrarCliente")
public class SvRegistrarCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvRegistrarCliente() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("registrarCliente.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		ManipularUsuarioDAO dao = new ManipularUsuarioDAO();
		UsuarioVO cliente = new UsuarioVO(request.getParameter("email"), request.getParameter("nombre"), request.getParameter("apellidos"), 
											request.getParameter("pwd"), request.getParameter("calle"),request.getParameter("pisoPuerta"), 
											request.getParameter("codpostal"), request.getParameter("tel"), false);
		
		boolean clienteInsertado = dao.insertarUsuario(cliente, false);
		if (clienteInsertado) {    // Cliente insertado en base datos	
			session.setAttribute("cliente", cliente);
			request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
		} else {     // ERROR - Ya existe cliente
			request.setAttribute("error", "Usuario ya registrado");
			request.getRequestDispatcher("registrarCliente.jsp").forward(request, response);
		}
	}
}
