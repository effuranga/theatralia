package daos;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;


/**
 * Esta clase es un Singleton, hecho para poder manejar conexiones de a una y cerrarlas desde la capa 
 * de servicios. De esta forma no necesitamos hacer la logica en la capa DAO 
 * @author Eff
 *
 */
public class DBHandler {
	private static DBHandler instance;
	private Connection conn;
	
	public static DBHandler getInstance() {
		if(instance==null) {
			instance = new DBHandler();
		}
		return instance;
	}
	
	public Connection getConnection(){
		try {			
			InitialContext ctx = new InitialContext();
			DataSource ds=(DataSource) ctx.lookup("java:comp/env/jdbc/theatralia");			
			this.conn= ds.getConnection();
								
			return conn;
		}
		catch(Exception e){
			e.printStackTrace();
		}	
		return null;
	}
	
	public void closeConnection(){
		try {
			this.conn.close(); 
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
