package servlet.montarCachimba;

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
 * Servlet implementation class SvEliminarMontarCachimba
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvEliminarMontarCachimba")
public class SvEliminarMontarCachimba extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvEliminarMontarCachimba() {
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
		int idProducto =  Integer.parseInt(request.getParameter("ProductoSeleccionado"));

        int base = Integer.parseInt(request.getParameter("base"));
        int mastil = Integer.parseInt(request.getParameter("mastil"));
        int manguera = Integer.parseInt(request.getParameter("manguera"));
        int cazoleta = Integer.parseInt(request.getParameter("cazoleta"));
        String encaje = request.getParameter("encaje");

        // Genera el productoVO a traves del dao
        ManipularProductoDAO dao = new ManipularProductoDAO();
	    ProductoVO producto = dao.datosProducto(idProducto);
        

        switch(producto.getNombreTipoProducto()){
            case("base"):
                base = 0;
                if (mastil == 0) {
                    encaje = "0";
                }
            break;
            case("mastil"):
                mastil = 0;
                if (base == 0) {
                    encaje = "0";
                }
            break;
            case("manguera"):
                manguera = 0;
            break;
            case("cazoleta"):
                cazoleta = 0;
            break;
        }
        
        request.setAttribute("base", base);
        request.setAttribute("mastil", mastil);
        request.setAttribute("manguera", manguera);
        request.setAttribute("cazoleta", cazoleta);
        request.setAttribute("encaje", encaje);

        request.getRequestDispatcher("pantallaMontarCachimbas.jsp").forward(request, response);
	}

}
