package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO.ManipularProductoDAO;
import model.VO.ProductoVO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvDecisionProducto
 * Ver un producto
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvDecisionProducto")
public class SvDecisionProducto extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvDecisionProducto() {
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
		UsuarioVO admin = (UsuarioVO) session.getAttribute("admin");
		if (admin == null) {
			request.setAttribute("error", "Sesión caducada");
			request.getRequestDispatcher("iniciarSesionAdmin.jsp").forward(request, response);
		}

        // Obtener idProducto
		int idProducto =  Integer.parseInt(request.getParameter("verProducto"));

        // Genera el productoVO a traves del dao
        ManipularProductoDAO dao = new ManipularProductoDAO();
	    ProductoVO producto = dao.datosProducto(idProducto);

        // Lo guarda y pasa a la pantalla de eleccion				
		request.setAttribute("producto", producto);
		request.getRequestDispatcher("pantallaAceptarRechazarOferta.jsp").forward(request, response);
	}

}
