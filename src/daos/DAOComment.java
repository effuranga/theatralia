package daos;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Iterator;
import java.util.Set;


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
		
		String qry = "SELECT C.*, U.userName, U.profImage FROM theatralia.comment C INNER JOIN theatralia.user U ON C.userId = U.userId "
				+ "WHERE C.playId = "+playId+" AND C.valid = 1 ORDER BY parentId ASC;"; //AND U.status = 1
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

	/**
	 * Da de alta un registro en la tabla likes para un usuario likeador y el comment likeado
	 * @param userId
	 * @param commentId
	 * @return
	 */
	public boolean likeComment(int userId, int commentId) {
		Connection conn = connect();
		String sql = "INSERT INTO `theatralia`.`like` (`commentId`, `userId`) VALUES ("+commentId+", "+userId+");"; 
				
		System.out.println(sql);
		try {
			PreparedStatement statement = conn.prepareStatement(sql);
			int affectedRows = statement.executeUpdate();
			
			if(affectedRows != 0) {
				done();
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		done();
		return false;
	}

	/**
	 * Elimina un registro de la tabla Likes 
	 * @param userId
	 * @param commentId
	 * @return
	 */
	public boolean dislikeComment(int userId, int commentId) {
		Connection conn = connect();
		String sql = "DELETE FROM `theatralia`.`like` "
				+ "WHERE `commentId` = "+commentId+" AND `userId` = "+userId+";"; 
				
		System.out.println(sql);
		try {
			PreparedStatement statement = conn.prepareStatement(sql);
			int affectedRows = statement.executeUpdate();
			
			if(affectedRows != 0) {
				done();
				return true;
			}
		}
		catch(SQLException e){
			e.printStackTrace();
		}
		done();
		return false;
	}
	
	/**
	 * Devuelve los rows de la tabla LIKES que concuerden con los ids parametros (de los comments)
	 * @param commentsIds
	 * @return rs o NULL
	 */
	public ResultSet getLikesForComments(Set<Integer> commentsIds) {
		Connection conn = connect();
		String list = createListOfIDs(commentsIds);
		String qry = "SELECT * FROM theatralia.like "
				+ "WHERE commentId IN ("+list+");";
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
	
	private String createListOfIDs(Set<Integer> ids) {
		String list ="";	
		
		Iterator<Integer> iterator = ids.iterator();
		while(iterator.hasNext()) {
			list += iterator.next()+",";
		}
		
		list = list.substring(0, list.length()-1);
		
		return list;
	}

	/**
	 * Devuelve comentarios del usuario parametro, hijos como padres, y de los hijos, los respectivos padres (escritos por otros
	 * usuarios), en estado VALID = 1 /comentarios no banneados/ mas el a�adido del nombre de la PLAY
	 * @param userId
	 * @return rs
	 */
	public ResultSet getCommentsForUser(int userId) {
		Connection conn = connect();
		
		String qry = "SELECT distinct C.*, U.`userName`, U.`profImage`, P.`name` AS \"playName\" \r\n" + 
				"FROM `theatralia`.`comment` C \r\n" + 
				"INNER JOIN `theatralia`.`user` U ON C.`userId` = U.`userId` \r\n" + 
				"INNER JOIN `theatralia`.`play` P ON C.`playId` = P.`playId` \r\n" + 
				"WHERE C.`valid` = 1 AND C.`userId` = "+userId+" OR C.`commentId` IN (\r\n" + 
				"-- Comentarios padre de hijos del user\r\n" + 
				"SELECT distinct CP.`parentId`\r\n" + 
				"FROM `theatralia`.`comment` CP\r\n" + 
				"WHERE CP.`userId` = "+userId+" AND CP.`parentId` IS NOT NULL)\r\n " +
				"ORDER BY C.`parentId` ASC;";
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
