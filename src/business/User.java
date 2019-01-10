package business;

import java.util.Date;

public class User {
	public static String ADMIN = "ADMIN";
	public static String EMPLOYEE = "EMPLOYEE";
	public static String CLIENT = "CLIENT";
	
	private int userId, status;
	private String userName, name, lastName, profImage, email, role;
	private Date birthday;
	private String created;
	
	public User(int userId, String userName, String name, String lastName, Date birthday, int status, String profImage, String email) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.name = name;
		this.lastName = lastName;
		this.birthday = birthday;
		this.status = status;
		this.profImage = profImage;
		this.email = email;
	}
	

	public User(int userId, int status, String userName, String name, String lastName, String email, String created, String role) {
		super();
		this.userId = userId;
		this.status = status;
		this.userName = userName;
		this.name = name;
		this.lastName = lastName;
		this.email = email;
		this.created = created;
		
		if(role.equals(User.ADMIN)) this.role = User.ADMIN;
		if(role.equals(User.CLIENT)) this.role = User.CLIENT;
		if(role.equals(User.EMPLOYEE)) this.role = User.EMPLOYEE;
		
	}

	public User(int userId, int status, String userName, String name, String lastName, String email, String created, String role, Date birthday, String profImage) {
		super();
		this.userId = userId;
		this.status = status;
		this.userName = userName;
		this.name = name;
		this.lastName = lastName;
		this.email = email;
		this.created = created;
		
		if(role.equals(User.ADMIN)) this.role = User.ADMIN;
		if(role.equals(User.CLIENT)) this.role = User.CLIENT;
		if(role.equals(User.EMPLOYEE)) this.role = User.EMPLOYEE;
		
		this.birthday = birthday;
		this.profImage = profImage;
		
	}

//	
//	int userId
//	String userName
//	String name
//	String lastName 
//	int status 
//	String email
//	String created
//	int roleId
//	
	
	public User(int id) {
		super();
		this.userId = id;
	}


	//Getters and setters
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public String getProfImage() {
		return profImage;
	}
	public void setProfImage(String profImage) {
		this.profImage = profImage;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	/**
	 * 
	 * @param role: any of these constants {ADMIN, EMPLOYEE, CLIENT}
	 */
	public void setRole(String role) {
		this.role = role;
	}
	
	public boolean isAdmin() {
		if(this.role.equals(ADMIN)) return true;
		else return false;
	}
	
	public boolean isClient() {
		if(this.role.equals(CLIENT)) return true;
		else return false;
	}
	
	public boolean isEmployee() {
		if(this.role.equals(EMPLOYEE)) return true;
		else return false;
	}
	
	public String getRole() {
		return this.role;
	}
	
	/**
	 * Es para saber si tengo una direccion en la imagen o es null
	 * @return TRUE si tiene una imagen, FALSE si la imagen es null o "noimage.jpg"
	 */
	private boolean hasImage() {
		if(this.profImage != null && !this.profImage.equals("noimage.jpg")) {
			return true;
		}
		return false;
	}

	/**
	 * Devuelve la locación donde buscar la imagen de usuario, dependiendo si tiene el 
	 * id seteado en profImage en DB o no
	 * @return userPictures/ID.jpg o utils/nouser.png
	 */
	public String imageSRC() {
		String imageSRC = "";
		if(hasImage()){
			imageSRC = "userPictures/"+getProfImage();
		}
		else{
			imageSRC = "utils/nouser.png";
		}
		
		return imageSRC;
	}
	
	
}
