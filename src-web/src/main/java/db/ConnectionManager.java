package db;

import java.sql.*;

/**  * Clase que abstrae la conexion con la base de datos.  */

public class ConnectionManager {
	// JDBC nombred el driver y URL de BD 
	private static final String JDBC_DRIVER = "org.postgresql.Driver";  

	// Para conectarse a una base de datos postgres en local
	//private static final String DB_URL = "jdbc:postgresql://localhost:5432/postgres?currentSchema=test_sisinf";

	// Para conectarse a la base de datos del contenedor sisinf-database
	private static final String DB_URL = "jdbc:postgresql://sisinf-database:5432/postgres?currentSchema=test_sisinf";
	
	// Credenciales de la Base de Datos
	private static final String USER = "postgres";
	private static final String PASS = "sisinf";
	
	// Devuelve una nueva conexion.
	public final static Connection getConnection() throws SQLException {
		Connection conn = null;

		try{
			//STEP 1: Register JDBC driver
			Class.forName(JDBC_DRIVER);
			//STEP 2: Open a connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_URL,USER,PASS);
			return conn; 
		} catch (Exception e) {
			e.printStackTrace();
			return null; 
		} 
	}
	
	// Libera la conexion, devolviendola al pool 
	public final static void releaseConnection(Connection conn) throws SQLException {
		conn.close(); 
	}
}

