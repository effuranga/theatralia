package utils;

public class DTOCreateUserForm {
	private String userName;
	private String password;
	private String roleId;
	private String name;
	private String lastName;
	private String email;
	private String birthday;
	
	
	
	public DTOCreateUserForm(String userName, String password, String roleId, String name, String lastName,
			String email, String birthday) {
		super();
		this.userName = userName;
		this.password = password;
		this.roleId = roleId;
		this.name = name;
		this.lastName = lastName;
		this.email = email;
		this.birthday = birthday;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	
}
