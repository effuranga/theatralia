package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

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

	/**
	 * Elimina el registro en la tabla likes para un usuario likeador y el comentario likeado
	 * @param userId
	 * @param commentId
	 * @return true si todo bien, sino false
	 */
	public boolean likeComment(int userId, int commentId) {
		DAOComment daoComment = new DAOComment();
		
		return daoComment.likeComment(userId, commentId);
	}
	
	public boolean dislikeComment(int userId, int commentId) {
		DAOComment daoComment = new DAOComment();
		
		return daoComment.dislikeComment(userId, commentId);
	}

	/**
	 * Toma el HashMap jerarquizado (solo con los padres) y lo desjerarquiza, crea un HashMap de un solo
	 * escalón, padres e hijos, para luego ubicar sus likes en cada comentario - sin importar su nivel
	 * @param parents
	 */
	public void fillWithLikes(HashMap<Integer, Comment> parents) {
		if(parents.isEmpty()) return;
		
		DAOComment daoComment = new DAOComment();
		HashMap<Integer, Comment> allComments = new HashMap<Integer, Comment>(); // HashMap desjerarquizado, su primer nivel tiene tanto padres como hijos
		
		allComments.putAll(parents); //Meto a los padres
		
		// Tengo que meter a los hijos
		Set<Integer> set = parents.keySet();
		for(int idParent : set) {	//Para cada padre
			allComments.putAll(parents.get(idParent).getYourChildrenAsHashMap()); // Le pido sus hijos y los meto a allComments en formato HashMap
		}
		
		ResultSet rs = daoComment.getLikesForComments(allComments.keySet());
		
		if(rs == null) return;
		
		try {
			while(rs.next()) {
				int commentId = rs.getInt("commentId");
				int userId = rs.getInt("userId");
				
				//Tengo que encontrar el comment al cual añadirle el like, puede ser padre o hijo
				allComments.get(commentId).addLike(userId);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		daoComment.done();
	}

	/**
	 * Devuelve un comentario que puede ser un padre o un hijo, buscando entre el HashMap de los padres
	 * @param comments
	 * @param id
	 * @return
	 */
	public Comment locateCommentInCollection(HashMap<Integer, Comment> comments, int id) {
		//Si es un padre
		if(comments.get(id) != null) {
			return comments.get(id);
		}
		
		//Si es un hijo, tengo que empezar a recorrer los padres
		Set<Integer> set = comments.keySet();
		for(int idParent : set) {
			ArrayList<Comment> children = comments.get(idParent).getChildren();
			for(Comment child : children) {
				if(child.getId() == id) {
					return child;
				}
			}
		}
		return null;
	}

}
