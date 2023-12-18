package servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.DAO.ManipularProductoDAO;

/**
 * Servlet implementation class SvAgnadirUnidades
 * Añade unidades a un producto
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvAgnadirUnidades")
public class SvAgnadirUnidades extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvAgnadirUnidades() {
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

		// Obtener idProducto y unidades
	 	int idProducto =  Integer.parseInt(request.getParameter("agnadir"));
	 	int unidades = Integer.parseInt(request.getParameter("unidades"));
	    dao.agnadirUnidades(idProducto, unidades);

	    request.setAttribute("mensaje", "Se han añadido las unidades con exito");
	    request.getRequestDispatcher("pantallaPrincipalAdmin.jsp").forward(request, response); 
	}

}
