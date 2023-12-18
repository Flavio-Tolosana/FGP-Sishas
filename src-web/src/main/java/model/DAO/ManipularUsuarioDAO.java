package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import db.ConnectionManager;
//import db.PoolConnectionManager;
import model.VO.UsuarioVO;


/**
 * Dao que manipula la tabla usuario
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class ManipularUsuarioDAO {
	
	// Seleccionar correo de los clientes mediante correo electrónico (clave primaria)
	private static String seleccionarUsuario = "SELECT correoelectronico FROM usuario WHERE correoelectronico = ? AND esadmin = ?";
	
	// Seleccionar correo de los clientes que tengan la contrasegna indicada
	private static String validarUsuario = "SELECT correoelectronico FROM usuario WHERE correoelectronico = ? AND contrasegna = ? AND esadmin = ?";
	
	// Obtener la información de un usuario mediante el email
	private static String obtenerUsuario = "SELECT * FROM usuario WHERE correoelectronico = ?";
	
	// Insertar nuevo cliente
	private static String insertarNuevoCliente = "INSERT INTO usuario (correoelectronico, nombre, apellidos, contrasegna, calle, pisopuerta, codigopostal, numerotelefono, esadmin) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?) ";
	
	// Insertar nuevo admin
	private static String insertarNuevoAdmin = "INSERT INTO usuario (correoelectronico, nombre, apellidos, contrasegna, esadmin) VALUES (?, ?, ?, ?, ?) ";
		
	
	/**
	 * 
	 * @param email es el correoElectronico de un cliente o administrador
	 * @param esAdmin define si el email es de administrador o de cliente
	 * @return true si ha encontrado a un usuario con dicho correo
	 */
	public boolean existeUsuario(String email, Boolean esAdmin) { 
		boolean result = false;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(seleccionarUsuario);
			findPs.setString(1, email);     
			findPs.setBoolean(2, esAdmin);   

			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			result = findRs.next();
			findPs.close();
			findRs.close();
		} catch(SQLException se) {
			se.printStackTrace();  
		
		} catch(Exception e) {
			e.printStackTrace(System.err); 
		} finally {
			//PoolConnectionManager.releaseConnection(conn); 
			/////////////////////////////////////////////////////////////////////
				try {
				if (conn != null) {
					ConnectionManager.releaseConnection(conn);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			/////////////////////////////////////////////////////////////////////
		}
		return result;
	}
	

	/**
	 * 
	 * @param email es el correoElectronico de un cliente o administrador
	 * @param contrasegna es la contraseña de un cliente o administrador
	 * @param esAdmin define si el email es de administrador o de cliente
	 * @return true si ha encontrado a un usuario con dicho correo y contraseña
	 */
	public boolean validarUsuario(String email, String contrasegna, Boolean esAdmin) { 
		boolean result = false;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(validarUsuario);
			findPs.setString(1, email);           
			findPs.setString(2, contrasegna);
			findPs.setBoolean(3, esAdmin);
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			result = findRs.next();
			findPs.close();
			findRs.close();
		} catch(SQLException se) {
			se.printStackTrace();  
		
		} catch(Exception e) {
			e.printStackTrace(System.err); 
		} finally {
			//PoolConnectionManager.releaseConnection(conn); 
			/////////////////////////////////////////////////////////////////////
				try {
				if (conn != null) {
					ConnectionManager.releaseConnection(conn);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			/////////////////////////////////////////////////////////////////////
		}
		return result;
	}
	
	/**
	 * 
	 * @param usuario es el usuario que se quiere introducir en la BD
	 * @param esAdmin define si el usuario es cliente o administrador
	 * @return true si ha conseguido añadir usuario a la BD (si el usuario no existía ya)
	 */
	public boolean insertarUsuario(UsuarioVO usuario, Boolean esAdmin) { 
		boolean existeUsuario = false;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Mirar si existe el usuario, bien como cliente o administrador
			existeUsuario = existeUsuario(usuario.getCorreoElectronico(), esAdmin) || 
			                existeUsuario(usuario.getCorreoElectronico(), !esAdmin);
			if (esAdmin && !existeUsuario) {   // Hay que insertar un administrador
				// Preparar consulta
				PreparedStatement insertPs = conn.prepareStatement(insertarNuevoAdmin);
				insertPs.setString(1, usuario.getCorreoElectronico());
				insertPs.setString(2, usuario.getNombre());
				insertPs.setString(3, usuario.getApellidos());
				insertPs.setString(4, usuario.getContrasegna());	
				insertPs.setBoolean(5, esAdmin);
				// Ejecutamos la consulta 
				insertPs.execute();
				insertPs.close();
			}
			else if (!esAdmin && !existeUsuario) {    // Hay que insertar un cliente
				// Preparar consulta
				PreparedStatement insertPs = conn.prepareStatement(insertarNuevoCliente);
				insertPs.setString(1, usuario.getCorreoElectronico());
				insertPs.setString(2, usuario.getNombre());
				insertPs.setString(3, usuario.getApellidos());
				insertPs.setString(4, usuario.getContrasegna());	
				insertPs.setString(5, usuario.getCalle());
				insertPs.setString(6, usuario.getPisoPuerta());
				insertPs.setString(7, usuario.getCodigoPostal());
				insertPs.setString(8, usuario.getNumeroTelefono());
				insertPs.setBoolean(9, esAdmin);
				// Ejecutamos la consulta 
				insertPs.execute();
				insertPs.close();
			}
		} catch(SQLException se) {
			se.printStackTrace();  
		
		} catch(Exception e) {
			e.printStackTrace(System.err); 
		} finally {
			//PoolConnectionManager.releaseConnection(conn); 
			/////////////////////////////////////////////////////////////////////
				try {
				if (conn != null) {
					ConnectionManager.releaseConnection(conn);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			/////////////////////////////////////////////////////////////////////
		}
		return !existeUsuario;
	}
	
	
	/**
	 * 
	 * @param email es el email de un usuario y dicho usuario existe en la base de datos
	 * @return la clase usuario el cual tiene ese email
	 */
	public UsuarioVO obtenerUsuario(String email) { 
		Connection conn = null;
		UsuarioVO usuario = new UsuarioVO();
		
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement obtenerUsuarioPs = conn.prepareStatement(obtenerUsuario);
			obtenerUsuarioPs.setString(1, email);

			// Ejecutar consulta
			ResultSet obtenerUsuarioRs = obtenerUsuarioPs.executeQuery();
			obtenerUsuarioRs.next();
			usuario.setCorreoElectronico(obtenerUsuarioRs.getString("correoelectronico"));
			usuario.setNombre(obtenerUsuarioRs.getString("nombre"));
			usuario.setApellidos(obtenerUsuarioRs.getString("apellidos"));
			usuario.setContrasegna(obtenerUsuarioRs.getString("contrasegna"));
			usuario.setCalle(obtenerUsuarioRs.getString("calle"));
			usuario.setPisoPuerta(obtenerUsuarioRs.getString("pisopuerta"));
			usuario.setCodigoPostal(obtenerUsuarioRs.getString("codigopostal"));
			usuario.setNumeroTelefono(obtenerUsuarioRs.getString("numerotelefono"));
			usuario.setEsAdmin(obtenerUsuarioRs.getBoolean("esadmin"));
			obtenerUsuarioPs.close();
			obtenerUsuarioRs.close();			
		} catch(SQLException se) {
			se.printStackTrace();  
		
		} catch(Exception e) {
			e.printStackTrace(System.err); 
		} finally {
			//PoolConnectionManager.releaseConnection(conn); 
			/////////////////////////////////////////////////////////////////////
				try {
				if (conn != null) {
					ConnectionManager.releaseConnection(conn);
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
			/////////////////////////////////////////////////////////////////////
		}
		return usuario;
	}
}
	


