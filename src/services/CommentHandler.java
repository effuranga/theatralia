package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;

import business.Comment;
import daos.DAOComment;

public class CommentHandler {

	/**
	 * Metodo que se usa para crear un comentario Padre - al primer nivel - de una obra
	 * @param userId
	 * @param playId
	 * @param text
	 * @return el id del comment o 0
	 */
	public int createParent(int userId, int playId, String text) {
		DAOComment daoComment = new DAOComment();
		
		return daoComment.createParent(userId, playId, text);
	}

	/**
	 * Metodo que se usa para crear un comentario Hijo - al segundo nivel - de una obra 
	 * @param parentId
	 * @param userId
	 * @param playId
	 * @param text
	 * @return el id del comment o 0
	 */
	public int createChild(int parentId, int userId, int playId, String text) {
		DAOComment daoComment = new DAOComment();
		
		return daoComment.createChild(parentId, userId, playId, text);
	}

	/**
	 * Este metodo devuelve todos los comentarios VALIDOS y sus hijos para una obra dada, SOLO DE USERS ACTIVOS
	 * @param playId
	 * @return comments lleno o empty
	 */
	public HashMap<Integer, Comment> getCommentsForPlay(int playId) {
		HashMap<Integer, Comment> comments = new HashMap<Integer, Comment>();
		
		DAOComment daoComment = new DAOComment();
		ResultSet rs = daoComment.getCommentsForPlay(playId);
		if(rs != null) {
			try {
				while(rs.next()) {
					//En el resultset, primero POR QUERY vienen los que tienen parentId en Null, o sea, los que son padres en sí
					//luego vienen todos los hijos
					int commentId = rs.getInt("commentId");
					int parentId = rs.getInt("parentId");
					int userId = rs.getInt("userId");
					String text = rs.getString("text");
					String date = rs.getString("date");
					String userName = rs.getString("userName");
					
					if(parentId == 0) { //Es un padre
						comments.put(commentId, new Comment(commentId, userId, userName, playId, text, date));
					}
					else { //Es un hijo
						Comment parent = comments.get(parentId); //Obtengo al padre
						Comment child = new Comment(commentId, userId, userName, parentId, text, date);
						parent.addChild(child);
					}				
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		daoComment.done();
		return comments;
	}

}
