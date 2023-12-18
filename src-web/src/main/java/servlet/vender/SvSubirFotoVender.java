package servlet.vender;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import model.DAO.ManipularProductoDAO;
import model.VO.UsuarioVO;

/**
 * Servlet implementation class SvSubirFotoVender
 */
@WebServlet("/SvSubirFotoVender")
@MultipartConfig

public class SvSubirFotoVender extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SvSubirFotoVender() {
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
		
		int idProducto = Integer.parseInt(request.getParameter("subirFoto"));
		
		String relativePath = "";
		String realPath = "";
		String nuevoFileName = "";
		String photo = "";
		
		try {
			Part part = request.getPart("imagen");
			if (part == null) {
				System.out.println("No se ha cogido bien la foto");
				return;
			}

		    relativePath = session.getServletContext().getInitParameter("upload.location");
		    realPath = session.getServletContext().getRealPath(relativePath);
		    File uploadsDirectory = new File(realPath);
			nuevoFileName = String.valueOf(idProducto) + ".png";      // Guardar nombre archivo
			InputStream input = part.getInputStream();
			if (input != null) {
				File file = new File(uploadsDirectory, nuevoFileName);
				Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
				photo = relativePath + nuevoFileName;
				dao.agnadirFoto(idProducto, photo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	    request.setAttribute("mensaje", "Producto subido para vender con éxito");
	    request.getRequestDispatcher("pantallaListadoVentas.jsp").forward(request, response);
	}

}
