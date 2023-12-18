package servlet.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.DAO.ManipularProductoDAO;
import model.VO.AtributosVO;
import model.VO.ProductoVO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvSubirProductoAdmin
 * Un administrador sube un producto a la base de datos
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
@WebServlet("/SvSubirProductoAdmin")
public class SvSubirProductoAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvSubirProductoAdmin() {
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
		ManipularProductoDAO dao = new ManipularProductoDAO();

		 // Cargar información producto
	    ProductoVO producto = new ProductoVO();
	    producto.setNombre(request.getParameter("nombre"));
	    producto.setEstadoProducto("Primera Mano");
	    producto.setMarca(request.getParameter("marca"));
	    producto.setColor(request.getParameter("color"));
	    producto.setPrecio(Float.parseFloat(request.getParameter("precio")));
	    int tipoProducto = dao.tipoProducto(request.getParameter("nombreTipoProducto"));
	    producto.setTipoProducto(tipoProducto);
	    producto.setEstadoVenta("Vendido");
	    producto.setPrecioVenta((float)0.0);
	    producto.setUnidades(Integer.parseInt(request.getParameter("unidades")));
	    producto.setUrlFoto("test_project_sisinf/imagenes/productos/");
	    producto.setUsuarioVendedorProducto(admin.getCorreoElectronico());

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
	    request.getRequestDispatcher("pantallaSubirFotoProducto.jsp").forward(request, response);
	}

}
