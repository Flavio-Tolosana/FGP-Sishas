package servlet.vender;

import java.io.IOException;
import javax.servlet.ServletException;
//import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
//import javax.servlet.http.Part;

import model.DAO.ManipularProductoDAO;
import model.VO.AtributosVO;
import model.VO.ProductoVO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvSubirProductoUsu
 * Un usuario sube un producto a la base de datos para intentar venderlo
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvSubirProductoUsu")
public class SvSubirProductoUsu extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvSubirProductoUsu() {
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
				request.getRequestDispatcher("iniciarSesion.jsp").forward(request, response);
			}
			ManipularProductoDAO dao = new ManipularProductoDAO();

		    // Cargar información producto
		    ProductoVO producto = new ProductoVO();
		    producto.setNombre(request.getParameter("nombre"));
		    producto.setEstadoProducto("Segunda Mano");
		    producto.setMarca(request.getParameter("marca"));
		    producto.setColor(request.getParameter("color"));
		    producto.setPrecio((float)0.0);
		    int tipoProducto = dao.tipoProducto(request.getParameter("nombreTipoProducto"));
		    producto.setTipoProducto(tipoProducto);
		    producto.setEstadoVenta("Espera");
		    producto.setPrecioVenta((float)0.0);
		    producto.setUnidades(1);
		    producto.setUrlFoto("test_project_sisinf/imagenes/productos/");
		    producto.setUsuarioVendedorProducto(cliente.getCorreoElectronico());

		    // Introducir el producto
		    int idProducto = dao.insertarProducto(producto);

		    // Se obtiene el idAtributoTipo dado un tipoProducto (en esta primera verisón solo hay un atributo por producto)
		    int idAtributoTipo = dao.tipoAtributo(tipoProducto);
		    // Añadir valorAtributo a la tabla Atributos
		    AtributosVO atributo = new AtributosVO();
		    atributo.setProducto(idProducto);
		    atributo.setAtributoTipo(idAtributoTipo);
		    // Con javascript se le da valor al button con name vender: se le da el nombreTipo del producto
		    atributo.setValorAtributo(request.getParameter(request.getParameter("vender")));
		    dao.insertarAtributos(atributo);
		    
		    request.setAttribute("idProducto", idProducto);
		    request.getRequestDispatcher("pantallaSubirFotoVentas.jsp").forward(request, response);
	}

}
