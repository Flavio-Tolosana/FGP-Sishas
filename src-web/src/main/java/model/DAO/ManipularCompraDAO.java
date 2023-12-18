package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;

import db.ConnectionManager;
import model.VO.ProductoVO;

/**
 * Dao que manipula la tabla compra
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class ManipularCompraDAO {
	
	
	// Suma los precios de los productos de una compra de un usuario
	private static String sumaPrecios = "SELECT SUM(precio * cantidad) AS precioTotal "
								      + "FROM compras "
								      + "WHERE correoelectronico = ? AND tiempocompra = ? "
								      + "GROUP BY correoelectronico";
	
	// Obtener los tiempoCompra de un usuario
	private static String listaTiempoCompras = "SELECT DISTINCT tiempocompra FROM compras "
				                             + "WHERE correoelectronico = ?";
		
	// Obtiener los atributos de los productos de un usuario en un tiempoCompra
	private static String listaProductosCompra = "SELECT p.idproducto, p.nombre, p.estadoproducto, p.marca, p.color, c.precio, p.tipoproducto, t.nombretipo, p.estadoventa, p.precioventa, p.unidades, p.urlfoto, c.cantidad "
											   + "FROM compras c "
											   + "JOIN producto p ON c.idproducto = p.idproducto "
											   + "JOIN tipos t ON p.tipoproducto = t.idtipo "
											   + "WHERE c.correoelectronico = ? AND c.tiempocompra = ? ";
		
	
	/**
	 * 
	 * @param email es la clave primaria de un usuario
	 * @param es la fecha y hora en la que el usuario hizo la compra
	 * @return Devuelve el precio que le costó a un usuario una compra
	 */
	public double sumaPrecioCompra(String email, String tiempoCompra) {

		float result = (float)0.0;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(sumaPrecios);
			findPs.setString(1, email);
			findPs.setString(2, tiempoCompra);
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			if (findRs.next()) {
				float precioTotal = findRs.getFloat("precioTotal");
				result = precioTotal;
			}
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
	 * @param email es la clave primaria de un usuario
	 * @return Devuelve una lista de tiempos (fecha y hora) en la que se hizo una compra
	 */
	public Set<String> listaCompras(String email) {
		Set<String> tiemposCompras = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listaTiempoCompras);
			findPs.setString(1, email);
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			while (findRs.next()) {   // Mientras haya productos
				String tiempoCompra = findRs.getString("tiempocompra");
				tiemposCompras.add(tiempoCompra);
			}
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
		return tiemposCompras;
	}
	
	/**
	 * 
	 * @param email usuario realiza compra
	 * @param tiempoCompra el tiempo (fecha y hora en el que se realizó)
	 * @return un listado de productos que es la compra que hizo el usuario en el tiempoCompra
	 */
	public Set<ProductoVO> listaProductosCompra(String email, String tiempoCompra) {

		Set<ProductoVO> productosCompra = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listaProductosCompra);
			findPs.setString(1, email);
			findPs.setString(2, tiempoCompra);
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			while (findRs.next()) {   // Mientras haya productos
				ProductoVO producto = new ProductoVO();
				producto.setIdProducto(findRs.getInt("idproducto"));
				producto.setNombre(findRs.getString("nombre"));
				producto.setPrecio(findRs.getFloat("precio"));
				producto.setNombreTipoProducto(findRs.getString("nombretipo"));
				producto.setEstadoProducto(findRs.getString("estadoproducto"));
				producto.setUrlFoto(findRs.getString("urlfoto"));
				// Poner cantidad seleccionada del carrito
				producto.setUnidades(findRs.getInt("cantidad"));  
				productosCompra.add(producto);
			}
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
		return productosCompra;
	}

}
	


