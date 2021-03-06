package business;

import java.util.ArrayList;
import java.util.HashMap;

import utils.FileExistenceValidator;

public class Comment {
	private int id;
	private int userId;
	private int playId;
	private int parentId;
	private String text;
	private String userName;
	private String date;
	private ArrayList<Comment> children;
	private boolean isParent;
	private ArrayList<Integer> likes; //Lista de userIds que likearon este comment
	private String playName; //Para mostrar en el perfil del usuario
	private String userProfImage;
	
	/**
	 * Devuelve una coleccion con el id de todos los hijos
	 * @return
	 */
	public ArrayList <Integer> getAllYourChildrenIDs(){
		ArrayList <Integer> childrenIDs = new ArrayList <Integer>();
		for(Comment child : this.children) {
			childrenIDs.add(child.getId());
		}
		return childrenIDs;
	}
	
	
	
	/**
	 * Constructor para Padre
	 * @param id
	 * @param userId
	 * @param playId
	 * @param text
	 * @param date
	 */
	public Comment(int id, int userId, String userName, int playId, String text, String date, String userProfImage) {
		super();
		this.id = id;
		this.userId = userId;
		this.userName = userName;
		this.playId = playId;
		this.text = text;
		this.date = date;
		this.isParent = true;
		this.children = new ArrayList<Comment>();
		this.likes = new ArrayList<Integer> ();
		this.userProfImage = userProfImage;
	}
	
	/**
	 * Constructor para Padre con playName
	 * @param id
	 * @param userId
	 * @param playId
	 * @param text
	 * @param date
	 * @param playName
	 */
	public Comment(int id, int userId, String userName, int playId, String text, String date, String playName, String userProfImage) {
		super();
		this.id = id;
		this.userId = userId;
		this.userName = userName;
		this.playId = playId;
		this.text = text;
		this.date = date;
		this.isParent = true;
		this.children = new ArrayList<Comment>();
		this.likes = new ArrayList<Integer> ();
		this.playName = playName;
		this.userProfImage = userProfImage;
		
	}
	
	/**
	 * Constructor para hijo
	 * @param id
	 * @param userId
	 * @param playId
	 * @param parentId
	 * @param text
	 * @param date
	 */
	public Comment(int id, int userId, String userName, int playId, int parentId, String text, String date, String userProfImage) {
		super();
		this.id = id;
		this.userId = userId;
		this.userName = userName;
		this.playId = playId;
		this.parentId = parentId;
		this.text = text;
		this.date = date;
		this.isParent = false;
		this.children = new ArrayList<Comment>();
		this.likes = new ArrayList<Integer> ();
		this.userProfImage = userProfImage;
		
	}
	
	public HashMap<Integer, Comment> getYourChildrenAsHashMap(){
		HashMap<Integer, Comment> children = new HashMap<Integer, Comment>();
		for(Comment child : this.children) {
			children.put(child.getId(), child);
		}
		return children;
	}
	
	/**
	 * Devuelve el n�mero de likes del comment
	 * @return 
	 */
	public int amountOfLikes() {
		return this.likes.size();
	}
	
	/**
	 * Verifica si el usuario parametro like� este comment
	 * @param userId
	 * @return true si est� likeado por userId, sino false
	 */
	public boolean hasMyLike(int userId) {
		for(int id : this.likes) {
			if(id == userId) {
				return true;
			}
		}
		return false;
	}
	
	public void addLike(int userId) {
		this.likes.add(userId);
	}
	
	public ArrayList<Integer> getLikes() {
		return likes;
	}

	public void setLikes(ArrayList<Integer> likes) {
		this.likes = likes;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getId() {
		return id;
	}
	public boolean isParent() {
		return isParent;
	}

	public void setParent(boolean isParent) {
		this.isParent = isParent;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public void setId(int id) {
		this.id = id;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getPlayId() {
		return playId;
	}
	public void setPlayId(int playId) {
		this.playId = playId;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public ArrayList<Comment> getChildren() {
		return children;
	}
	public void setChildren(ArrayList<Comment> children) {
		this.children = children;
	}

	public void addChild(Comment child) {
		this.children.add(child);
		
	}	
	public String getPlayName() {
		return playName;
	}
	public void setPlayName(String playName) {
		this.playName = playName;
	}

	public String getUserProfImage() {
		return userProfImage;
	}

	public void setUserProfImage(String userProfImage) {
		this.userProfImage = userProfImage;
	}



	/**
	 * Metodo para aplicar a los padres y saber si tienen comentarios hijos
	 * @return
	 */
	public boolean hasChildren() {
		if(this.children.isEmpty()) {
			return false;
		}
		return true;
	}
	
	/**
	 * Devuelve la locaci�n donde buscar la imagen de usuario, dependiendo si tiene el 
	 * id seteado en profImage en DB o no y de si existe en el disco, ubibacion absoluta
	 * @return userPictures/ID.jpg o utils/nouser.png
	 */
	public String imageSRC() {
		String imageSRC = "";
		if(this.userProfImage != null && !this.userProfImage.equals("nouser.jpg") && FileExistenceValidator.userImageExists(this.userProfImage)){
			imageSRC = "userPictures/"+this.userProfImage;
		}
		else{
			imageSRC = "utils/nouser.png";
		}
		
		return imageSRC;
	}
}
