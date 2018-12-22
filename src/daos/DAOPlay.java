package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;


/**
 * Como los otros DAOs, devuelve ResultSets para ser manejados
 * por el PlayHandler principalmente.
 * NO se encarga de crear objetos, solo de pasar info de la DB
 * NO se encarga de conectar con la DB
 * @author Eff
 *
 */
public class DAOPlay extends DAO {

	public boolean changePlayStatus(int playId, int toStatus) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`play` SET `status` = "+toStatus+" WHERE (`playId` = "+playId+");"; 
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			done();
			return false;
		}
	}
	
	public boolean updatePlay(String id, String name, String description, String author) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`play` SET `name` = '"+name+"', `description` = '"+description+"', `author` = '"+author+"' WHERE (`playId` = '"+id+"');"; 
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			done();
			return false;
		}
	}
	
	
	/**
	 * Sirve para pedir las obras que no están hidden
	 * @return resultSet con los registros que devuelva la consulta SQL
	 */
	public ResultSet getCurrentPlays() {
		Connection conn = connect();
					
		String qry = "SELECT * FROM theatralia.play WHERE status=1;";

		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * Devuelve un ResultSet con las rows de play que concuerden con la lista de IDs
	 * @param playIdList
	 * @return rs o null
	 */
	public ResultSet getThesePlays(ArrayList<String> playIdList) {
		Connection conn = connect();
					
		String qry = "SELECT * FROM theatralia.play WHERE playId IN("+createListOfIDs(playIdList)+");";

		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	public ResultSet getStarredPlays() {
		Connection conn = connect();
		
		String qry = "SELECT * FROM theatralia.play WHERE starred = 1;";

		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * Este metodo da de alta una obra en estado 0 (hidden), con su información básica.
	 * @param name
	 * @param description
	 * @param author
	 * @return id - el id de la obra recién creada o 0 si hubo un error
	 */
	public int createPlay(String name, String description, String author) {
		Connection conn = connect();
		String sql = "INSERT INTO `theatralia`.`play` (`name`, `description`, `author`, `status`) VALUES ('"+name+"', "+description+", "+author+", '0');"; 
				
		System.out.println(sql);
		try {
			PreparedStatement statement = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			int affectedRows = statement.executeUpdate();
			
			if(affectedRows == 0) {
				done();
				return 0;
			}
			else {
				ResultSet rs = statement.getGeneratedKeys();
				if(rs.next()) {
					System.out.print("ID es= ");System.out.print(rs.getInt(1));
					int id = rs.getInt(1);
					done();
					return id;
				}
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		done();
		return 0;
	
	}

	/**
	 * Genera el resultset con la Play y su información básica para ser trabajada por el PlayHandler
	 * @param id
	 * @return rs con la row de la Play
	 */
	public ResultSet getBasicPlay(String id) {
		Connection conn = connect();
		
		String qry = "SELECT * FROM theatralia.play WHERE playId = "+id+";";
System.out.println(qry);
		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	public void setImage(int id) {
		Connection conn = connect();
		String image = Integer.toString(id)+".jpg";
		String sql = "UPDATE `theatralia`.`play` SET `image` = '"+image+"' WHERE (`playId` = '"+id+"');"; 
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
	}
	
	/**
	 * Genera el resultset con toda la tabla de plays
	 * @return
	 */
	public ResultSet getAllPlays() {
		Connection conn = connect();
		
		String qry = "SELECT * FROM theatralia.play";

		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * Genera el resultset con el record de la Play segun id
	 * @param id: para matchear en la tabla Play
	 * @return
	 */
	public ResultSet getWholePlay(int id) {
		Connection conn = connect();
		
		String qry = "SELECT * FROM theatralia.play WHERE playId = "+id+";";

		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * Genera la lista dentro de la clausula IN con los IDs de la play, todos con coma menos el último
	 * @param ids
	 * @return list
	 */
	private String createListOfIDs(ArrayList<String> ids) {
		String list ="";	
		int size = ids.size();
		
		for(int i = 0; i<size-1; i++) {
			list += ids.get(i)+",";
		}
		list += ids.get(size-1);
		
		return list;
	}
	
}
