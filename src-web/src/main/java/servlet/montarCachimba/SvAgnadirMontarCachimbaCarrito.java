package servlet.montarCachimba;

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
 * Servlet implementation class SvAgnadirMontarCachimbaCarrito
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvAgnadirMontarCachimbaCarrito")
public class SvAgnadirMontarCachimbaCarrito extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvAgnadirMontarCachimbaCarrito() {
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

        int base = Integer.parseInt(request.getParameter("base"));
        int mastil = Integer.parseInt(request.getParameter("mastil"));
        int manguera = Integer.parseInt(request.getParameter("manguera"));
        int cazoleta = Integer.parseInt(request.getParameter("cazoleta"));

        CarritoVO baseCarrito = new CarritoVO(cliente.getCorreoElectronico(), base, 1);
        CarritoVO mastilCarrito = new CarritoVO(cliente.getCorreoElectronico(), mastil, 1);
        CarritoVO mangueraCarrito = new CarritoVO(cliente.getCorreoElectronico(), manguera, 1);
        CarritoVO cazoletaCarrito = new CarritoVO(cliente.getCorreoElectronico(), cazoleta, 1);

        ManipularCarritoDAO dao = new ManipularCarritoDAO();

        // Insertar productos diferentes de 0 en el carrito del cliente
        if (base != 0) {
            dao.insertarProductoCarrito(baseCarrito);
        }
        if (mastil != 0) {
            dao.insertarProductoCarrito(mastilCarrito);
        }
        if (manguera != 0) {
            dao.insertarProductoCarrito(mangueraCarrito);
        }
        if (cazoleta != 0) {
            dao.insertarProductoCarrito(cazoletaCarrito);
        }
        
        request.setAttribute("mensaje", "Producto Añadido al Carrito");
        request.getRequestDispatcher("pantallaPrincipal.jsp").forward(request, response);
	}

}
