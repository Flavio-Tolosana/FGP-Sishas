package model.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedHashSet;
import java.util.Set;

import db.ConnectionManager;
import model.VO.AtributosVO;
//import db.PoolConnectionManager;
import model.VO.ProductoVO;

/**
 * Dao que manipula la tabla producto y las tablas relacionadas
 * 
 * @author Gonzalo Valero Domingo
 * @author Flavio Tolosana Hernando
 * @author Pablo Pina Gracia
 */
public class ManipularProductoDAO {
	
	// Selecciona los atributos idproducto, nombre, precio, urlfoto, nombretipo, 
	// unidades de un producto.
	// Hay que especificar si estadoProducto es:
	//                                           - "Primera Mano"
	//                                           - "Segunda Mano"
	// Y si estadoVenta es:
	//                       - "Vendido"
	//                       - "Oferta"
	//                       - "Espera"
	//                       - "Rechazado"
	//                       - "Eliminado"
	private static String listarProductos = "SELECT idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto, nombretipo "
										  + "FROM (producto JOIN tipos ON producto.tipoproducto = tipos.idtipo) "
										  + "WHERE estadoproducto = ? AND estadoventa = ? "
							    		  + "ORDER BY idproducto";
	
	// Encontrar idTipo dato el nombreTipo
    private static String findTipoProducto = "SELECT idtipo FROM tipos WHERE nombretipo = ?";

    // Encontrar el idAtributosTipo dado un tipoProducto
    private static String findTipoAtributo = "SELECT idatributostipo FROM atributostipo WHERE tipoProducto = ? ";

    // Añadir en los dos el nombre de secuendia en select nextval('')
    private static String insertProduct = "INSERT INTO producto (idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto) "
    		                            + "VALUES (nextval('test_sisinf.producto_idproducto_seq'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) returning idproducto";
    
    // Insertar atributos
    private static String insertAtributos = "INSERT INTO atributos (idatributo, producto, atributotipo, valoratributo) "
    		                              + "VALUES (nextval('test_sisinf.atributos_idatributo_seq'), ?, ?, ?)";	

    // Actualizar el estadoventa y precioventa de un producto con idproducto
    private static String estadoVentaUpdt = "UPDATE producto SET estadoventa = ?, precioventa = ? WHERE idproducto = ?";

	// Actualizar la foto de un producto idproducto
    private static String fotoUpdt = "UPDATE producto SET urlfoto = ? WHERE idproducto = ?";
    
    // Aumentar las unidades de un producto
   	private static String aumentarUnidades = "UPDATE producto SET unidades = unidades + ? "
   										   + "WHERE idproducto = ?";

	// Elimina un producto
    private static String eliminarProducto = "UPDATE producto SET estadoventa = ? "
    		                               + "WHERE idproducto = ?";
	
	// Selecciona el valor de un atributo de un producto y tipoatributo específicos
    private static String findIdAtributoExtra = "SELECT idatributostipo FROM atributostipo WHERE tipoproducto = ?";
    
	// Selecciona el valor de un atributo de un producto y tipoatributo específicos
	private static String findAtributoExtra = "SELECT valoratributo FROM atributos WHERE producto = ? AND atributotipo = ?";
    		
	// Selecciona todos los atributos de un producto
    private static String findProducto = "SELECT idproducto, nombre, estadoproducto, marca, color, precio, tipoproducto, estadoventa, precioventa, unidades, urlfoto, usuariovendedorproducto, nombretipo "
    		                           + "FROM (producto JOIN tipos ON producto.tipoproducto = tipos.idtipo) WHERE idproducto = ?";
    
	// Listar los productos de una determinada catergoría
    private static String listarProductosCategoria = "SELECT idproducto, nombre, precio, urlfoto, nombretipo, unidades "
			   									   + "FROM (producto JOIN tipos ON producto.tipoproducto = tipos.idtipo) "
			   									   + "WHERE estadoproducto = ? AND estadoventa = ? AND tipoproducto = ? "
			   									   + "ORDER BY idproducto";

	// Listar los productos de una determinada catergoría y un encaje específico
    private static String listarProductosMontarCachimbas = "SELECT idproducto, nombre, precio, urlfoto, nombretipo, unidades "
														 + "FROM (producto JOIN tipos ON producto.tipoproducto = tipos.idtipo "
														 + "JOIN atributos ON producto.idProducto = atributos.producto) "
														 + "WHERE estadoproducto = ? AND estadoventa = ? AND tipoproducto = ? AND valoratributo = ? "
														 + "ORDER BY idproducto";
    
	// Listar los productos que haya vendido un usuario
    private static String listarProductosVenta = "SELECT idproducto, nombre, estadoventa, precioventa "
											   + "FROM producto "
											   + "WHERE usuariovendedorproducto = ? "
											   + "ORDER BY idproducto";
    
    // Modificar precio de un producto
    private static String modificarPrecioProducto = "UPDATE producto SET precio = ? "
    		                                      + "WHERE idproducto = ?";
    
    // Elimina un producto
    private static String eliminarProductoRechazado = "DELETE FROM producto WHERE idproducto = ?";
    
    // Elimina los atributos de un producto
    private static String eliminarAtributosProductoRechazado = "DELETE FROM atributos WHERE producto = ?";
    
    // Aumentar las unidades de un producto
   	private static String modificarPrecio = "UPDATE producto SET precio = ? "
   										  + "WHERE idproducto = ?";
 
    
    /**
     * 
     * @param primeraMano es un booleano, es true si se quiere obtener los productos 
     * de primera mano y false si se quiere obtener los productos de segunda mano
     * @param estadoVenta debe ser: "Vendido" / "Oferta" / "Espera" / "Rechazado"
     * @return set de los productos de primera mano o segunda mano, los cuales están 
     * en el estadoventa, estadoVenta
     */
	public Set<ProductoVO> listaProductos(Boolean primeraMano, String estadoVenta) {
		
		Set<ProductoVO> productos = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listarProductos);
			if (primeraMano) {
				findPs.setString(1, "Primera Mano");
			} else {
				findPs.setString(1, "Segunda Mano");
			}
			findPs.setString(2, estadoVenta); 

			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			while (findRs.next()) {
				ProductoVO producto = new ProductoVO();
				producto.setIdProducto(findRs.getInt("idproducto"));
				producto.setNombre(findRs.getString("nombre"));
				producto.setEstadoProducto(findRs.getString("estadoproducto"));
				producto.setMarca(findRs.getString("marca"));
				producto.setColor(findRs.getString("color"));
				producto.setPrecio(findRs.getFloat("precio"));
				producto.setTipoProducto(findRs.getInt("tipoproducto"));
				producto.setNombreTipoProducto(findRs.getString("nombretipo"));
				producto.setEstadoVenta(findRs.getString("estadoventa"));
				producto.setPrecioVenta(findRs.getFloat("precioventa"));
				producto.setUnidades(findRs.getInt("unidades"));
				producto.setUrlFoto(findRs.getString("urlfoto"));
				producto.setUsuarioVendedorProducto(findRs.getString("usuariovendedorproducto"));
				productos.add(producto);
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
		return productos;
	}
	
	/**
	 * 
	 * @param nombreTipoProducto es el tipo de un producto
	 * @return Devuleve el idtipo de la tabla tipos que coincide con nombreTipoProducto
	 */
    public int tipoProducto(String nombreTipoProducto){
		int result = -1;
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();
			
			// Preparar consulta
            PreparedStatement findTP = conn.prepareStatement(findTipoProducto);
            findTP.setString(1, nombreTipoProducto);

            // Ejecutar consulta
            ResultSet resultFindTP = findTP.executeQuery();
            if (resultFindTP.next()) {
            	int idTipo = resultFindTP.getInt("idtipo");
            	result = idTipo;
            }
            resultFindTP.close();
            findTP.close();
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
     * @param idTipo es la clave primaria de la tabla tipos
     * @return idAtributosTipo de la tabla AtributosTipo dependiendo del nombre e idTipo
     */
    public int tipoAtributo(int idTipo){
		int result = -1;
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
            PreparedStatement findTA = conn.prepareStatement(findTipoAtributo);
            findTA.setInt(1, idTipo);

            // Ejecutar consulta
            ResultSet resultFindTA = findTA.executeQuery();
            if (resultFindTA.next()) {
				int idAtributo = resultFindTA.getInt(1);
				result = idAtributo;
			}
            resultFindTA.close();
            findTA.close();
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
     * @param product, producto que se quiere insertar
     * @return idProducto con el cual ha sido insertado
     */
    public int insertarProducto(ProductoVO product){
		int result = -1;
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
            PreparedStatement insertP = conn.prepareStatement(insertProduct, Statement.RETURN_GENERATED_KEYS);
            insertP.setString(1, product.getNombre());
            insertP.setString(2, product.getEstadoProducto());
            insertP.setString(3, product.getMarca());
            insertP.setString(4, product.getColor());
            insertP.setFloat(5, product.getPrecio());
            insertP.setInt(6, product.getTipoProducto());
            insertP.setString(7, product.getEstadoVenta());
            insertP.setFloat(8, product.getPrecioVenta());
            insertP.setInt(9, product.getUnidades());
            insertP.setString(10, product.getUrlFoto());
            insertP.setString(11, product.getUsuarioVendedorProducto());

            // Ejecutar consulta
            int  filasAfectadas = insertP.executeUpdate();
            if (filasAfectadas > 0) {
            	ResultSet idGenerado = insertP.getGeneratedKeys();
            	if (idGenerado.next()) {
            		int idProducto = idGenerado.getInt(1);
    				result = idProducto;
            	}
            	idGenerado.close();
            }
            insertP.close();
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
     * Inserta un atributo en la tabla Atributos
     * 
     * @param atributo son los atributos que se quiere insertar en Atributos
     */
    public void insertarAtributos(AtributosVO atributo){
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
            PreparedStatement insertA = conn.prepareStatement(insertAtributos);
            insertA.setInt(1, atributo.getProducto());
            insertA.setInt(2, atributo.getAtributoTipo());
            insertA.setString(3, atributo.getValorAtributo());
            
            // Ejecutar consulta
            insertA.executeUpdate();
            insertA.close();
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
     * Modifica el esadoVenta y el precioVenta de un 
     * 
     * @param idProducto clave primaria de producto
     * @param estadoVenta debe ser: "Vendido" / "Oferta" / "Espera" / "Rechazado"
     * @param precioVenta es el precio de una venta de un usuario
     */
    public void modificarEstadoVenta (int idProducto, String estadoVenta, float precioVenta) {

    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
            PreparedStatement updtEV = conn.prepareStatement(estadoVentaUpdt);
            updtEV.setString(1, estadoVenta);
            updtEV.setFloat(2, precioVenta);
            updtEV.setInt(3, idProducto);
			
			// Ejecutar consulta
            updtEV.executeUpdate();
            updtEV.close();
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
     * Añade la dirección de la imagen de un producto
     * 
     * @param idProducto es la clave primaria de un producto
     * @param url es la dirección absoluta de la imagen
     */
    public void agnadirFoto (int idProducto, String url) {

    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
            PreparedStatement updtF = conn.prepareStatement(fotoUpdt);
            updtF.setString(1, url);
            updtF.setInt(2, idProducto);
			
			// Ejecutar consulta
            updtF.executeUpdate();
            updtF.close();
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
     * Añade unidades al producto
     * 
     * @param idProducto clave primaria de producto
     * @param cantidad que se quiere sumar a unidades
     */
    public void agnadirUnidades (int idProducto, int cantidad) {
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
	        PreparedStatement aumentar = conn.prepareStatement(aumentarUnidades);
	        aumentar.setInt(1, cantidad);
	        aumentar.setInt(2, idProducto);
			
			// Ejecutar consulta
	        aumentar.executeUpdate();
	        aumentar.close();
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
     * Elimina un producto
     * 
     * @param idProducto clave primaria de producto
     */
    public void eliminarProducto(int idProducto) {
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consultas
            PreparedStatement deleteProducto = conn.prepareStatement(eliminarProducto);
			deleteProducto.setString(1, "Eliminado");
			deleteProducto.setInt(2, idProducto);
         
			// Ejecutar consultas
            deleteProducto.executeUpdate();
			deleteProducto.close();
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
     * @param idProducto es la clave primaria de un producto
     * @param idAtributoTipo es la clave primaria de AtributosTipo
     * @return El valor de un atributo de un producto y tipoatributo específicos
     */
    public String valorAtributoExtra(int idProducto, int idAtributoTipo) {
		Connection conn = null;
		String result = "";	
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta 1
			PreparedStatement findIdAEx = conn.prepareStatement(findIdAtributoExtra);
			
			findIdAEx.setInt(1, idAtributoTipo);
			
			// Ejecutar consulta 1
			ResultSet resultFindIdAEx = findIdAEx.executeQuery();
			if (resultFindIdAEx.next()) {
				// Preparar consulta 2
				PreparedStatement findAEx = conn.prepareStatement(findAtributoExtra);
				findAEx.setInt(1, idProducto);
				findAEx.setInt(2, resultFindIdAEx.getInt("idatributostipo"));
				// Ejecutar consulta 2
				ResultSet resultFindAEx = findAEx.executeQuery();
				if (resultFindAEx.next()) {
					result = resultFindAEx.getString("valoratributo");
				}
				findAEx.close();
				resultFindAEx.close();
			}
			findIdAEx.close();
			resultFindIdAEx.close();
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
     * @param idProducto clave primaria de producto
     * @return todos los datos de un producto
     */
    public ProductoVO datosProducto(int idProducto){
        Connection conn = null;
		ProductoVO producto = null;
		producto = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consultaç
			PreparedStatement findPs = conn.prepareStatement(findProducto);
            findPs.setInt(1, idProducto);
			
			// Ejecutar consulta
			ResultSet resultFindP = findPs.executeQuery();
			if (resultFindP.next()) {
				producto = new ProductoVO();
				producto.setIdProducto(idProducto);
                producto.setNombre(resultFindP.getString("nombre"));
                producto.setMarca(resultFindP.getString("marca"));
                producto.setEstadoProducto(resultFindP.getString("estadoproducto"));
                producto.setColor(resultFindP.getString("color"));
                producto.setPrecio(resultFindP.getFloat("precio"));
				producto.setTipoProducto(resultFindP.getInt("tipoproducto"));
                producto.setEstadoVenta(resultFindP.getString("estadoventa"));
                producto.setPrecioVenta(resultFindP.getFloat("precioventa"));
                producto.setUnidades(resultFindP.getInt("unidades"));
                producto.setUrlFoto(resultFindP.getString("urlfoto"));
				producto.setUsuarioVendedorProducto(resultFindP.getString("usuariovendedorproducto"));                
                producto.setNombreTipoProducto(resultFindP.getString("nombretipo")); 
			}   
            findPs.close();
            resultFindP.close();
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
		return producto;
    }
    
    /**
     * 
     * @param primeraMano es un booleano, es true si se quiere obtener los productos 
     * de primera mano y false si se quiere obtener los productos de segunda mano
     * @param estadoVenta debe ser: "Vendido" / "Oferta" / "Espera" / "Rechazado"
	 * @param tipo es un entero que representa el tipo de productos que se desea mostrar
     * @return set de los productos de primera mano o segunda mano, los cuales están 
     * en el estadoventa, estadoVenta y son del tipo tipo
     */
	public Set<ProductoVO> listaProductosCategoria(Boolean primeraMano, String estadoVenta, int tipo) {
		
		Set<ProductoVO> productos = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listarProductosCategoria);
			if (primeraMano) {
				findPs.setString(1, "Primera Mano");
			} else {
				findPs.setString(1, "Segunda Mano");
			}
			findPs.setString(2, estadoVenta); 
			findPs.setInt(3, tipo); 

			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			while (findRs.next()) {
				ProductoVO producto = new ProductoVO();
				producto.setIdProducto(findRs.getInt("idproducto"));
				producto.setNombre(findRs.getString("nombre"));
				producto.setPrecio(findRs.getFloat("precio"));
				producto.setNombreTipoProducto(findRs.getString("nombretipo"));
				producto.setUrlFoto(findRs.getString("urlfoto"));
				producto.setUnidades(findRs.getInt("unidades"));
				productos.add(producto);
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
		return productos;
	}
	
	/**
	 * 
     * @param correoVendedor string que contiene un correo electrónico
     * @return set de los productos vendidos por el vendedor al que le pertenece
	 * el correo correoVendedor
     */
	public Set<ProductoVO> listaProductosVenta(String correoVendedor) {
		
		Set<ProductoVO> productos = new LinkedHashSet<>();
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(listarProductosVenta);
			findPs.setString(1, correoVendedor);

			// Ejecutar consulta
			ResultSet findRs = findPs.executeQuery();
			while (findRs.next()) {
				ProductoVO producto = new ProductoVO();
				producto.setIdProducto(findRs.getInt("idproducto"));
				producto.setNombre(findRs.getString("nombre"));
				producto.setEstadoProducto(findRs.getString("estadoventa"));
				producto.setPrecioVenta(findRs.getFloat("precioventa"));
				productos.add(producto);
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
		return productos;
	}
	
	public void modificarPrecioProducto(int idProducto, float precio) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection(); 

			// Preparar consulta
			PreparedStatement findPs = conn.prepareStatement(modificarPrecioProducto);
			findPs.setFloat(1, precio);
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
     * Elimina un producto que ha sido rechazado
     * 
     * @param idProducto clave primaria de producto
     */
    public void eliminarProductoRechazado(int idProducto) {
    	Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consultas
            PreparedStatement deleteAtributosProducto = conn.prepareStatement(eliminarAtributosProductoRechazado);
            deleteAtributosProducto.setInt(1, idProducto);
            PreparedStatement deleteProducto = conn.prepareStatement(eliminarProductoRechazado);
			deleteProducto.setInt(1, idProducto);

			// Ejecutar consultas
            deleteAtributosProducto.executeUpdate();
            deleteAtributosProducto.close();
            deleteProducto.executeUpdate();
			deleteProducto.close();
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
     * @param primeraMano es un booleano, es true si se quiere obtener los productos 
     * de primera mano y false si se quiere obtener los productos de segunda mano
     * @param estadoVenta debe ser: "Vendido" / "Oferta" / "Espera" / "Rechazado / "Eliminado"
	 * @param tipo es un entero que representa el tipo de productos que se desea mostrar
	 * @param encaje es un string que representa el valor del encaje, en caso de ser una base o un mástil, si es otro
	 * tipo se le pasa 0 y dentro se llamará a listaProductosCategoria
     * @return set de los productos de primera mano o segunda mano, los cuales están 
     * en el estadoventa, estadoVenta, son del tipo tipo y tienen como atributo el encaje
     */
	public Set<ProductoVO> listaProductosMontar(Boolean primeraMano, String estadoVenta, int tipo, String encaje) {
		Set<ProductoVO> productos = new LinkedHashSet<>();
		
		if(!encaje.equals("0")){
			Connection conn = null;
			try {
				// conn = PoolConnectionManager.getConnection(); 
				conn = ConnectionManager.getConnection(); 

				// Preparar consulta
				PreparedStatement findPs = conn.prepareStatement(listarProductosMontarCachimbas);
				if (primeraMano) {
					findPs.setString(1, "Primera Mano");
				} else {
					findPs.setString(1, "Segunda Mano");
				}
				findPs.setString(2, estadoVenta); 
				findPs.setInt(3, tipo); 
				findPs.setString(4, encaje);

				// Ejecutar consulta
				ResultSet findRs = findPs.executeQuery();
				while (findRs.next()) {
					ProductoVO producto = new ProductoVO();
					producto.setIdProducto(findRs.getInt("idproducto"));
					producto.setNombre(findRs.getString("nombre"));
					producto.setPrecio(findRs.getFloat("precio"));
					producto.setNombreTipoProducto(findRs.getString("nombretipo"));
					producto.setUrlFoto(findRs.getString("urlfoto"));
					producto.setUnidades(findRs.getInt("unidades"));
					productos.add(producto);
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
		}
		else{
			productos = listaProductosCategoria(primeraMano, estadoVenta, tipo);
		}
		return productos;
	}
	
    /**
     * 
     * @param idProducto es la clave primaria de producto
     * @param precio es el nuevo precio del producto
     */
	public void modificarPrecio(int idProducto, float precio) {
		Connection conn = null;
		try {
			// conn = PoolConnectionManager.getConnection(); 
			conn = ConnectionManager.getConnection();

			// Preparar consulta
	        PreparedStatement aumentar = conn.prepareStatement(modificarPrecio);
	        aumentar.setFloat(1, precio);
	        aumentar.setInt(2, idProducto);
			
			// Ejecutar consulta
	        aumentar.executeUpdate();
	        aumentar.close();
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
}
	


