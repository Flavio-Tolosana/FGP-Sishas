package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;

import db.ConnectionManager;
//import db.PoolConnectionManager;
import model.VO.CarritoVO;
import model.VO.ProductoVO;

/**
 * Dao que manipula la tabla carrito
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class ManipularCarritoDAO {
	
	// Obtiene todos los atributos de la tabla producto que tiene un usuario en su carrito
	private static String listaProductosCarrito = "SELECT p.idproducto, p.nombre, p.estadoproducto, p.marca, p.color, p.precio, p.tipoproducto, t.nombretipo, p.estadoventa, p.precioventa, p.unidades, p.urlfoto, c.cantidad "
													+ "FROM carrito c "
													+ "JOIN producto p ON c.idproducto = p.idproducto "
													+ "JOIN tipos t ON p.tipoproducto = t.idtipo "
													+ "WHERE c.correoelectronico = ? AND p.estadoventa = ? ";
	
	
	// Modifica la cantidad de un producto del carrito de un usuario. La cantidad es modificada.
	private static String modificarCantidad = "UPDATE carrito SET cantidad = ? "
											+ "WHERE correoelectronico = ? AND idproducto = ?";
	
	// Elimina del carrito de un usuario el producto
	private static String eliminarProducto = "DELETE FROM carrito "
											+ "WHERE correoelectronico = ? AND idproducto = ?";
	
	// Selecciona una fila del carrito específica
	private static String seleccionarProducto = "SELECT idproducto, correoelectronico, cantidad "
												+ "FROM carrito "
												+ "WHERE correoelectronico = ? AND idproducto = ?";
	
    // Aumentar la cantidad seleccionada de un producto del carrito de un usuario
	private static String aumentarCantidad = "UPDATE carrito SET cantidad = cantidad + ? "
											+ "WHERE correoelectronico = ? AND idproducto = ?";
	
	// Insertar un producto en el carrito de un usuario
	private static String insertarProductoEnCarrito = "INSERT INTO carrito (correoelectronico, idproducto, cantidad) VALUES (?, ?, ?) ";
	
	// Selecciona las unidades que quedan de un producto en stock y la cantidad
	// seleccionada de un producto en el carrito de un usuario
	private static String seleccionarUnidades = "SELECT cantidad, unidades "
												+ "FROM carrito JOIN producto ON carrito.idproducto = producto.idproducto "
												+ "WHERE correoelectronico = ? AND carrito.idproducto = ?";
	
	// Selecciona los idproducto cuales haya menos unidades en stock que cantidad
	// seleccionada por el usuario en su carrito
	private static String comprasNoPuedenRealizar = "SELECT carrito.idproducto "
												  + "FROM carrito JOIN producto ON carrito.idproducto = producto.idproducto "
												  + "WHERE correoelectronico = ? AND cantidad > unidades";
	
	// Suma los precios de los productos del carrito de un usuario
	private static String sumaPrecios = "SELECT SUM(p.precio * c.cantidad) AS precioTotal "
								      + "FROM carrito c JOIN producto p ON c.idProducto = p.idProducto "
								      + "WHERE c.correoelectronico = ? "
								      + "GROUP BY c.correoelectronico";
	
	// Reducir unidades de un producto
	private static String reducirUnidadesProducto = "UPDATE producto SET unidades = unidades - ? "
												  + "WHERE idproducto = ?";
	
	// Insertar producto que compro el usuario en el tiempoCompra (fecha y hora)
	private static String insertarProductoCompra = "INSERT INTO compras (correoelectronico, idproducto, cantidad, tiempocompra, precio) VALUES (?, ?, ?, ?, ?) ";


	/**
	 * 
	 * @param email es la clave primaria de un usuario
	 * @return Devuelve el conjunto de productos que hay en el carrito del usuario. 
	 * En el campo de unidades del ProductoVO irá la cantidad seleccionada por el usuario.
	 */
	public Set<ProductoVO> listaCarrito(String email) {

		Set<ProductoVO> productosCarrito = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listaProductosCarrito);
			findPs.setString(1, email);
			findPs.setString(2, "Vendido");
			
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
				productosCarrito.add(producto);
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
		return productosCarrito;
	}
	

	/**
	 * Modifica la cantidad seleccionada por un usuario de un producto
	 * 
	 * @param clase carrito tiene:
	 * 								- correoelectronico (clave Primaria usuario)
	 * 								- idproducto (clave Primaria producto)
	 * 								- cantidad (numero seleccionado por el usuario)
	 * Carrito es una entrada de la tabla carrito
	 * 
	 */
	public void actualizarCantidadProductoCarrito(CarritoVO carrito) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(modificarCantidad);
			findPs.setInt(1, carrito.getCantidad());    
			findPs.setString(2, carrito.getCorreoElectronico());     
			findPs.setInt(3, carrito.getIdProducto());  
			
			// Ejecutar consulta
			findPs.executeUpdate();  
			findPs.close(); 
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
	}
	
	/**
	 * Elimina el idProducto del carrito del usuario
	 * 
	 * @param email es la clave primaria de un usuario
	 * @param idProducto es el idProducto del carrito del usuario
	 */
	public void eliminarProductoCarrito(String email, int idProducto) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(eliminarProducto);
			findPs.setString(1, email);     
			findPs.setInt(2, idProducto);   
			
			// Ejecutar consulta
			findPs.executeUpdate();		
			findPs.close();
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
	}
	
	/**
	 * 
	 * @param email es la clave primaria de un usuario
	 * @param idProducto es la clave primaria de un producto
	 * @return Devuelve true si existe el producto en el carrito del usuario
	 */
	public Boolean existeProductoEnCarrito(String email, int idProducto) {
		boolean result = false;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(seleccionarProducto);
			findPs.setString(1, email);
			findPs.setInt(2, idProducto);
			
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
	 * Si el producto ya estaba en el carrito del usuario, aumentar la cantidad seleccionada
	 * Si el producto no estaba en el carrito del usuario, meterlo
	 * 
	 * @param carrito tiene:
	 *  					- correoelectronico (clave Primaria usuario)
	 *   					- idproducto (clave Primaria producto)
	 *   					- cantidad (numero seleccionado por el usuario)
	 * Carrito es una entrada de la tabla carrito
	 * 
	 */
	public void insertarProductoCarrito(CarritoVO carrito) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Si existe el producto en el carrito del usuario, aumentar la cantidad
			if (this.existeProductoEnCarrito(carrito.getCorreoElectronico(), carrito.getIdProducto())) {
				// Preparar consulta
				PreparedStatement findPs = conn.prepareStatement(aumentarCantidad);
				findPs.setInt(1, carrito.getCantidad());
				findPs.setString(2, carrito.getCorreoElectronico());
				findPs.setInt(3, carrito.getIdProducto());
				// Ejecutar consulta
				findPs.executeUpdate();		
				findPs.close();
			}
			else {  // No existe producto en el carrito del usuario, entonces insertarlo
				// Preparar consulta
				PreparedStatement insertPs = conn.prepareStatement(insertarProductoEnCarrito);	
				insertPs.setString(1, carrito.getCorreoElectronico());
				insertPs.setInt(2, carrito.getIdProducto());
				insertPs.setInt(3, carrito.getCantidad());
				// Ejecutar consulta 
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
	}

	/**
	 * 
	 * @param email es la clave primaria de usuario
	 * @param idProducto es la clave primaria de producto
	 * @return Si las unidades disponibles en stock del idProducto son mayores o igual
	 * que las unidades seleccionadas de ese producto en el carrito del usuario,
	 * devolver -1 (se puede realizar compra, en carrito.jsp se empleará)
	 * Si las unidades son menores que las seleccionadas, devovlerá las unidades
	 * que quedan en stock del producto
	 */
	public int posibleCompra(String email, int idProducto) {
		Connection conn = null;
		int result = 0;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(seleccionarUnidades);
			findPs.setString(1, email);
			findPs.setInt(2, idProducto);
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			findRs.next();
			int cantidad = findRs.getInt("cantidad");
			int unidades = findRs.getInt("unidades");
			// Hay más cantidad seleccionadas que unidades en stock
			if (unidades < cantidad) {
				result = unidades;
			} 
			else { // Si es posible efectuar la compra, devolver -1
				result = -1;
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
	 * @return Devuelve true si para todos los productos del carrito de un usuario
	 * hay suficiente stock para realizar la compra
	 */
	public Boolean posibleRealizarCompra(String email) {
		boolean result = false;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(comprasNoPuedenRealizar);
			findPs.setString(1, email); 
			
			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			result = !findRs.next();
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
	 * @return Devuelve el precio que cuesta el carrito de un usuario 
	 */
	public double sumaPrecioCarrito(String email) {

		float result = (float)0.0;
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(sumaPrecios);
			findPs.setString(1, email);
			
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
	 * Reduce las unidades de un producto
	 * 
	 * @param idProducto el clave primaria de un producto
	 * @param unidades las unidades que se quieren descontar del producto
	 */
	private void reducirUnidadesProducto(int idProducto, int unidades) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(reducirUnidadesProducto);
			findPs.setInt(1, unidades);    
			findPs.setInt(2, idProducto);     
			
			// Ejecutar consulta
			findPs.executeUpdate();  
			findPs.close(); 
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
	}
	
	/**
	 * Inserta en la tabla compras, qué usuario, cuántas unidades, 
	 * a qué precio estaba la unidad y cuando se hizo la compra
	 * 
	 * @param email clave primaria usuario
	 * @param idProducto clave primaria producto
	 * @param cantidad comprada del producto
	 * @param tiempoCompra, fecha y hora cuando se realizó la compra
	 * @param precio de un producto
	 */
	private void insertarProductoCompra(String email, int idProducto, int cantidad, String tiempoCompra, float precio) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 
			
			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(insertarProductoCompra);
			findPs.setString(1, email);
			findPs.setInt(2, idProducto);
			findPs.setInt(3, cantidad);
			findPs.setString(4, tiempoCompra);
			findPs.setFloat(5, precio);
			
			// Ejecutar consulta
			findPs.executeUpdate();		
			findPs.close();
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
	}


	/**
	 * Realizar compra, es decir, eliminar del carrito del usuario todos
	 * los productos y añadirlos en la tabla compras añadiendo en cada fila
	 * la fecha en la que se compró y el precio que costó
	 * 
	 * @param email es la clave primaria de un usuario
	 * @param tiempoCompra es la fecha y tiempo de cuando se realizó la compra
	 */
	public void realizarCompra(String email, String tiempoCompra) {
		
		Set<ProductoVO> productosCarrito = listaCarrito(email);
		for (ProductoVO producto : productosCarrito) {    // Iterar sobre todos los productos del carrito
			int idProducto = producto.getIdProducto(); // IdProducto del producto
			int unidades = producto.getUnidades();    // Unidades seleccionadas del producto en el carrito
			float precio = producto.getPrecio();     // Precio de una unidad del producto
			reducirUnidadesProducto(idProducto, unidades);
			insertarProductoCompra(email, idProducto, unidades, tiempoCompra, precio);
			eliminarProductoCarrito(email, idProducto);
		}
	}
}
	


