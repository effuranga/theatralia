package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DAOComment extends DAO{

	/**
	 * Crea un comentario padre y devuelve su id
	 * @param userId
	 * @param playId
	 * @param text
	 * @return id o 0
	 */
	public int createParent(int userId, int playId, String text) {
		Connection conn = connect();
		String sql = "INSERT INTO `theatralia`.`comment` (`playId`, `userId`, `text`) VALUES ("+playId+", "+userId+", \""+text+"\");"; 
				
		System.out.println(sql);
		try {
			PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			int affectedRows = statement.executeUpdate();
			
			if(affectedRows != 0) {
				ResultSet rs = statement.getGeneratedKeys();
				while(rs.next()) {
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
	 * Creo un comentario hijo y devuelvo su Id
	 * @param parentId
	 * @param userId
	 * @param playId
	 * @param text
	 * @return id o 0
	 */
	public int createChild(int parentId, int userId, int playId, String text) {
		Connection conn = connect();
		String sql = "INSERT INTO `theatralia`.`comment` (`parentId`, `playId`, `userId`, `text`) VALUES ("+parentId+", "+playId+", "+userId+", \""+text+"\");"; 
				
		System.out.println(sql);
		try {
			PreparedStatement statement = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			int affectedRows = statement.executeUpdate();
			
			if(affectedRows != 0) {
				ResultSet rs = statement.getGeneratedKeys();
				while(rs.next()) {
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
	 * Devuelve registro de la tabla comments para una obra dada y el estado valid = 1, SOLO DE USERS ACTIVOS
	 * @param playId
	 * @return rs
	 */
	public ResultSet getCommentsForPlay(int playId) {
		Connection conn = connect();
		
		String qry = "SELECT C.*, U.userName FROM theatralia.comment C INNER JOIN theatralia.user U ON C.userId = U.userId "
				+ "WHERE C.playId = "+playId+" AND C.valid = 1 AND U.status = 1 ORDER BY parentId ASC;";
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
}
