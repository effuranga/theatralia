package services;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import business.User;
import daos.DAOUser;
import utils.DTOCreateUserForm;
import utils.EmailValidator;

/**
 * Crea Users y maneja su inforación a nivel de negocio.
 * Obtiene los resultados de la DB desde su DAO
 * @author Eff
 *
 */
public class UserHandler {
	
	public User getUser(int userId) {
		DAOUser daoUser = new DAOUser();
		
		ResultSet rs = daoUser.getUser(userId);
		
		try {
			if(rs.next()) {
				String userName = rs.getString("userName"); 
				String name = rs.getString("name");
				String lastName = rs.getString("lastName"); 
				int status = rs.getInt("status");
				String email = rs.getString("email");
				String created = rs.getString("created");
				String role = rs.getString("description");
				Date birthday = rs.getDate("birthday");
				String profImage = rs.getString("profImage");
				
				daoUser.done();
				return(new User(userId, status, userName, name, lastName, email, created, role, birthday, profImage));
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();			
		}
		
		daoUser.done();
		return null;
	}
	
	public ArrayList<User> getAllUsers(){
		ArrayList<User> allUsers = new ArrayList<User>();
		DAOUser daoUser = new DAOUser();
		
		ResultSet rs = daoUser.getAllUsers();
		
		try {
			while(rs.next()) {
				int userId = rs.getInt("userId");
				String userName = rs.getString("userName"); 
				String name = rs.getString("name");
				String lastName = rs.getString("lastName"); 
				int status = rs.getInt("status");
				String email = rs.getString("email");
				String created = rs.getString("created");
				String role = rs.getString("description");
				
				allUsers.add(new User(userId, status, userName, name, lastName, email, created, role));
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();			
		}
		
		daoUser.done();
		return allUsers;
	}
	
	public boolean updateUserFields(int id, String userName, String name, String lastName, String birthday, String email) {
		DAOUser daoUser = new DAOUser();
		
		boolean result = daoUser.updateUserFields(id, userName, name, lastName, birthday, email);
		daoUser.done();
		return result;
	}
	
	/**
	 * Metodo usado para autenticar el usuario actual
	 * @param userName
	 * @param password
	 * @return loggedUser si es valido, sino NULL
	 */
	public User getLoggedUser(String userName, String password) {
		DAOUser daoUser = new DAOUser();
		
		ResultSet rs = daoUser.getUserByUserName(userName);
				
		try {
			if(rs.next()) {				
				String storedPassword = rs.getString("password");
				String rndSeed = rs.getString("rndSeed");
				String hashedPassword = get_SHA_512_SecurePassword(password, rndSeed);
					System.out.println("contra ingresada "+password);
					System.out.println("semilla "+rndSeed);
					System.out.println("hashed "+hashedPassword);
					System.out.println("contra en la base "+storedPassword);
				
				if(hashedPassword.equals(storedPassword)) {
					int userId = rs.getInt("userId");
					int status = rs.getInt("status");
					String name = rs.getString("name");
					String lastName = rs.getString("lastName");
					String profImage = rs.getString("profImage");
					Date birthday = rs.getDate("birthday");
					String email = rs.getString("email");
					User loggedUser = new User(userId, userName, name, lastName, birthday, status, profImage, email);
					
					daoUser.done();
					assignRole(loggedUser); //le asigno el rol antes de devolverlo a la app
					return loggedUser;	
				}				
			}
			System.out.println("esta null el rs o vacio");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		daoUser.done();
		return null;
	}	
	
	/**
	 * Este metodo corrobora que los datos ingresados por el usuario a la hora de hacer sign in
	 * sean correctos.
	 * @param userName
	 * @param password
	 * @param repPassword
	 * @param name
	 * @param lastName
	 * @param birthday
	 * @return ArrayList<String> errorsList VACIO si no se encontraron errores, con algo en caso contrario
	 */
	public ArrayList<String> validateSignInFields(String userName, String password, String repPassword ,String name, String lastName, String birthday, String email) {
		ArrayList<String> errorsList = new ArrayList<String>();
		DAOUser daoUser = new DAOUser();
		ResultSet rs = daoUser.getUserByUserName(userName);		
		try {
			if(rs.next()) {
				errorsList.add("El nombre de usuario ya está en uso");
			}
			else {
				if(userName.trim().isEmpty()) {
				errorsList.add("El nombre de usuario no puede quedar en blanco");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		rs = daoUser.getUserByEmail(email);	
		try {
			if(rs.next()) {
				errorsList.add("El email ya está en uso");
			}
			else {
				if(email.trim().isEmpty()) {
				errorsList.add("El email no puede quedar en blanco");
				}
				else {
					EmailValidator emailValidator = new EmailValidator();
					if(!emailValidator.validateEmail(email)) {
						errorsList.add("El formato del email es incorrecto");
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(password.trim().isEmpty()) {
			errorsList.add("La contraseña no puede quedar en blanco");
		}
		if(!password.equals(repPassword)) {
			errorsList.add("Las contraseñas no coinciden");
		}
		
		if(name.trim().isEmpty()) {
			errorsList.add("El nombre no puede quedar en blanco");
		}
		if(lastName.trim().isEmpty()) {
			errorsList.add("El apellido no puede quedar en blanco");
		}
		if(birthday.trim().isEmpty()) {
			errorsList.add("El nacimiento no puede quedar en blanco");
		}	
		
		daoUser.done();
		return errorsList;
	}
	
	
	public ArrayList<String> validateUpdateFields(int id, String userName, String name, String lastName, String birthday, String email){
		ArrayList<String> errorsList = new ArrayList<String>();
		DAOUser daoUser = new DAOUser();
		ResultSet rs = daoUser.getUserByUserName(userName);		
		try {
			if(rs.next()) {
				if(!rs.getString("userId").equals(Integer.toString(id))){ //el username no es de si mismo
					errorsList.add("El nombre de usuario ya está en uso");
				}				
			}
			else {
				if(userName.trim().isEmpty()) {
				errorsList.add("El nombre de usuario no puede quedar en blanco");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		rs = daoUser.getUserByEmail(email);	
		try {
			if(rs.next()) {
				if(!rs.getString("userId").equals(Integer.toString(id))){ //el email no es de sí mismo
					errorsList.add("El email ya está en uso");
				}				
			}
			else {
				if(email.trim().isEmpty()) {
				errorsList.add("El email no puede quedar en blanco");
				}
				else {
					EmailValidator emailValidator = new EmailValidator();
					if(!emailValidator.validateEmail(email)) {
						errorsList.add("El formato del email es incorrecto");
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		if(name.trim().isEmpty()) {
			errorsList.add("El nombre no puede quedar en blanco");
		}
		if(lastName.trim().isEmpty()) {
			errorsList.add("El apellido no puede quedar en blanco");
		}
		if(birthday.trim().isEmpty()) {
			errorsList.add("El nacimiento no puede quedar en blanco");
		}	
		
		daoUser.done();
		return errorsList;
	}
	
	public boolean setProfImage(int id) {
		DAOUser daoUser = new DAOUser();
		boolean result = daoUser.setImage(id);
		
		return result;
	}
	
	/**
	 * Este metodo da de alta un usuario en status = 2, pending, y genera un email de confirmacion. LO GENERA SIN ROL
	 * @param userName
	 * @param password
	 * @param name
	 * @param lastName
	 * @param birthday
	 * @param profImage
	 * @return TRUE si salió todo bien, FALSE si hubo algún error
	 */
	public boolean signIn(String userName, String password, String name, String lastName, String birthday, String email) {
		DAOUser daoUser = new DAOUser();
		String generatedPath = generateRandomString(45);
		String rndSeed = generateRandomString(20);
		String hashedPassword = get_SHA_512_SecurePassword(password, rndSeed);
		boolean valid = daoUser.signIn(userName, hashedPassword, name, lastName, birthday, email, generatedPath, rndSeed);
		
		if(valid) {
			sendEmail(email, generatedPath);
		}
		
		return valid;
	}
	
	
	/**
	 * Este metodo toma la contraseña en bruto y la semilla (salt) y devuelve el hash
	 * de su concatenación
	 * @param passwordToHash
	 * @param salt
	 * @return
	 */
	private String get_SHA_512_SecurePassword(String passwordToHash, String salt){
		String hashedPassword = null;
		    try {
		         MessageDigest md = MessageDigest.getInstance("SHA-512");
		         md.update(salt.getBytes(StandardCharsets.UTF_8));
		         byte[] bytes = md.digest(passwordToHash.getBytes(StandardCharsets.UTF_8));
		         StringBuilder sb = new StringBuilder();
		         for(int i=0; i< bytes.length ;i++){
		            sb.append(Integer.toString((bytes[i] & 0xff) + 0x100, 16).substring(1));
		         }
		         hashedPassword = sb.toString();
		        } 
		       catch (NoSuchAlgorithmException e){
		        e.printStackTrace();
		       }
		    return hashedPassword;
		}

	/**
	 * Genera un String aleatorio alfanumerico de longitud parametrizada
	 * @param int length
	 * @return String rndString
	 */
	private String generateRandomString(int len) {
		String AB = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
		SecureRandom rnd = new SecureRandom();
		StringBuilder sb = new StringBuilder(len);
		for( int i = 0; i < len; i++ ) {
			sb.append( AB.charAt( rnd.nextInt(AB.length()) ) );
		}		
		return sb.toString(); 
	}
	
	private void sendEmail(String email, String generatedPath) {
		//Enviar el mail
		System.out.println("Se envió");
	}
	
	/**
	 * Este metodo se usa para asignar el rol al usuario una vez creado
	 * @param user
	 */
	public void assignRole(User user) {
		DAOUser daoUser = new DAOUser();
		ResultSet rs = daoUser.getUserRole(user.getUserId());
		try {
			while(rs.next()) {
				String role = rs.getString("role");
				user.setRole(role);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		daoUser.done();
	}

	public boolean changeUserRole(int userId, int toRole) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.changeUserRole(userId, toRole);

	}
	
	public boolean changeUserStatus(int userId, int toStatus) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.changeUserStatus(userId, toStatus);

	}
	
	/**
	 * Cuando damos de alta un usuario, siendo Administrador, validamos el dto (los campos)
	 * y si todo va bien, lo creamos, sino, devolvemos los errores
	 * @param DTOCreateUserForm
	 * @return ArrayList<String> errors (lleno o vacío)
	 */
	public ArrayList<String> createUser(DTOCreateUserForm dto) {
		ArrayList<String> errors = new ArrayList<String>();
		DAOUser daoUser = new DAOUser();	
		try {
			//Validación de la existencia de un usuario ya con mismo EMAIL O USERNAME
			ResultSet rs = daoUser.getUserByUserName(dto.getUserName());
			if(rs.next()) errors.add("El nombre de usuario ya esta en uso");
			daoUser.done();
			rs = daoUser.getUserByEmail(dto.getEmail());
			if(rs.next()) errors.add("Ya hay un usuario con ese email");
			daoUser.done();
			
			//Si todo va bien, lo creo
			if(errors.isEmpty()) {			
				boolean valid = signIn(dto.getUserName(), dto.getPassword(), dto.getName(), dto.getLastName(), dto.getBirthday(), dto.getEmail());
				if(!valid) {	
					throw new SQLException();
				}
				
				//Necesito su ID para setearle el rol
				int toRole = Integer.parseInt(dto.getRoleId());
				boolean roleSet = insertRole(dto.getUserName(), toRole);
				if(!roleSet) errors.add("No se le asignó rol");
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			errors.add("DB problem");
		}
		
		return errors;
	}
	
	/**
	 * CREA un registro en userrole
	 * @param userId
	 * @param role
	 * @return
	 */
	public boolean insertRole(int userId, int role) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.insertRole(userId, role);
	}
	
	/**
	 * CREA un registro en userrole. Busca intermediamente el userId
	 * @param userName
	 * @param role
	 * @return true si se creo el registro, sino false
	 */
	public boolean insertRole(String userName, int role) {
		DAOUser daoUser = new DAOUser();
		
		ResultSet rs = daoUser.getUserByUserName(userName);
		try {
			if(rs.next()) {
				int userId = rs.getInt("userId");
				daoUser.done();
				return(insertRole(userId, role));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			daoUser.done();
			return false;
		}
		return false;
	}

	/**
	 * Checkea si para el usuario X, existe un record de la Play Y en la tabla userplay
	 * @param userId
	 * @param playId
	 * @return true si existe (está añadida en la biblioteca del user, sino false
	 */
	public boolean isThisPlayInLibrary(int userId, int playId) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.isThisPlayInLibrary(userId, playId);

	}

	/**
	 * Inserta en la tabla userplay (Library) un record para este usuario y obra
	 * @param userId
	 * @param playId
	 * @return
	 */
	public boolean addToLibrary(int userId, int playId) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.addToLibrary(userId, playId);
	}
	
	/**
	 * Elimina de la tabla userplay (Library) el record para este usuario y obra
	 * @param userId
	 * @param playId
	 * @return
	 */
	public boolean removeFromLibrary(int userId, int playId) {
		DAOUser daoUser = new DAOUser();
		
		return daoUser.removeFromLibrary(userId, playId);
	}

	/**
	 * Devuelve la lista de plays id de la Biblioteca para el usuario loggeado 
	 * @param userId
	 * @return ArrayList<String> playsIds (LLENO o VACIO)
	 */
	public ArrayList<String> playsInThisLibrary(int userId) {
		DAOUser daoUser = new DAOUser();
		ArrayList<String> playsIds = new ArrayList<String>();
		ResultSet rs = daoUser.playsInThisLibrary(userId);
		try {
			while(rs.next()) {
				playsIds.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		daoUser.done();
		return playsIds;
	}

	/**
	 * Devuelve un arreglo de Users VALIDOS cuyo nombre, apellido o username concuerde con la lista de palabras
	 * que recibe como parametro
	 * @param words
	 * @return usersResult lleno o vacio
	 */
	public ArrayList<User> getUsersBySearch(String[] words) {
		ArrayList<User> usersResult = new ArrayList<User>();
		DAOUser daoUser = new DAOUser();
		
		ResultSet rs = daoUser.getUsersBySearch(words);
		
		try {
			while(rs.next()) {
				int userId = rs.getInt("userId");
				String userName = rs.getString("userName"); 
				String name = rs.getString("name");
				String lastName = rs.getString("lastName"); 
				int status = rs.getInt("status");
				String email = rs.getString("email");
				String created = rs.getString("created");
				String role = rs.getString("description");
				
				usersResult.add(new User(userId, status, userName, name, lastName, email, created, role));
			}
			
		}
		catch (SQLException e) {
			e.printStackTrace();			
		}
		catch (NullPointerException e) {
			e.printStackTrace();			
		}
		
		daoUser.done();
		return usersResult;
	}
}
