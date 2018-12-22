package daos;

import java.sql.Connection;

public class DAO {
	protected Connection connect() {
		DBHandler dbHandler = DBHandler.getInstance();
		Connection conn = dbHandler.getConnection(); //System.out.println("ABRO CONEXION");
		return conn;
	}
	
	public void done() {
		DBHandler dbHandler = DBHandler.getInstance();
		dbHandler.closeConnection();  //System.out.println("CIERRO CONEXION");
	}
}
