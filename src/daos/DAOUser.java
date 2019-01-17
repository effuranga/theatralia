package daos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;



/**
 * Como los otros DAOs, devuelve ResultSets para ser manejados
 * por el UserHandler principalmente.
 * NO se encarga de crear objetos, solo de pasar info de la DB
 * NO se encarga de conectar con la DB
 * @author Eff
 *
 */
public class DAOUser extends DAO {
	
	/**
	 * Devuelve un resultset con todos los Users
	 * @return Resultset
	 */
	public ResultSet getAllUsers() {
		Connection conn = connect();
		String sql = "SELECT U.`userId`, U.`userName`, U.`name`, U.`lastName`, U.`status`, U.`email`, U.`created`, R.`description`\r\n" + 
				"FROM `user` U INNER JOIN `userrole` UR ON U.`userId` = UR.`userId`\r\n" + 
				"INNER JOIN `role` R ON UR.`roleId` = R.`roleId`" ;
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;		
	}

	public ResultSet getUser(int userId) {
		Connection conn = connect();
		String sql = "SELECT U.*, R.`description` FROM `user` U INNER JOIN `userrole` UR ON U.`userId` = UR.`userId`\r\n" + 
				"INNER JOIN `role` R ON UR.`roleId` = R.`roleId` WHERE U.userId =\""+userId+"\";" ;
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;	
	}

	public ResultSet getUserByUserName(String userName) {	
		Connection conn = connect();
		String sql = "SELECT * FROM theatralia.user WHERE userName =\""+userName+"\";" ;
		// Antes era +userName+"\" AND Status = 1;"
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;		
	}
	
	public ResultSet getUserByEmail(String email) {	
		Connection conn = connect();
		String sql = "SELECT * FROM theatralia.user WHERE email =\""+email+"\";" ;
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;		
	}

	public boolean signIn(String userName, String hashedPassword, String name, String lastName, String birthday, String email, String generatedPath, String rndSeed) {
		Connection conn = connect();
		
		String sql = "INSERT INTO `theatralia`.`user` (`name`, `lastName`, `password`, `rndSeed`, `birthday`, `userName`, `email`) VALUES ('"+name+"', '"+lastName+"', '"+hashedPassword+"', '"+rndSeed+"', '"+birthday+"', '"+userName+"', '"+email+"');";
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		done();
		return false;
	}

	public boolean updateUserFields(int id, String userName, String name, String lastName, String birthday, String email) {
		Connection conn = connect();
		String sql = "UPDATE `user`  SET `name` = \""+name+"\", `lastName` = \""+lastName+"\", `birthday` = \""+birthday+"\", `userName` = \""+userName+"\", `email` = \""+email+"\" "
				+ "WHERE `userId` = "+id+";";
		
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return false;
	}
	
	public boolean setImage(int id) {
		Connection conn = connect();
		String image = Integer.toString(id)+".jpg";
		String sql = "UPDATE `theatralia`.`user` SET `profImage` = '"+image+"' WHERE (`userId` = '"+id+"');"; 
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

	}
	
	public ResultSet getUserRole(int id) {	
		Connection conn = connect();
		String sql = "SELECT R.`description` AS \"role\" FROM userrole UR INNER JOIN role R on `UR`.`roleId`=R.`roleId` WHERE UR.`userId` = "+id+";" ;
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;		
	}


	public boolean changeUserRole(int userId, int toRole) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`userrole` SET `roleId` = "+toRole+" WHERE (`userId` = "+userId+");"; 
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
	
	public boolean changeUserStatus(int userId, int toStatus) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`user` SET `status` = "+toStatus+" WHERE (`userId` = "+userId+");"; 
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


	public boolean insertRole(int userId, int toRole) {
		Connection conn = connect();
		
		String sql = "INSERT INTO `theatralia`.`userrole` (`userId`, `roleId`) VALUES ("+userId+", "+toRole+");";
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		done();
		return false;
	}

	/**
	 * Checkea si para el usuario X, existe un record de la Play Y en la tabla userplay
	 * @param userId
	 * @param playId
	 * @return true si existe (está añadida en la biblioteca del user, sino false
	 */
	public boolean isThisPlayInLibrary(int userId, int playId) {
		Connection conn = connect();
		String sql = "SELECT * FROM userplay WHERE `userId` = "+userId+" AND `playId` = "+playId+";" ;
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			if(rs.next()) {
				done();
				return true;
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
		return false;
	}

	/**
	 * Inserta en la tabla userplay (Library) un record para este usuario y obra
	 * @param userId
	 * @param playId
	 * @return
	 */
	public boolean addToLibrary(int userId, int playId) {
		Connection conn = connect();
		
		String sql = "INSERT INTO `theatralia`.`userplay` (`userId`, `playId`) VALUES ("+userId+", "+playId+");";
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		done();
		return false;
	}
	
	/**
	 * Elimina de la tabla userplay (Library) el record para este usuario y obra
	 * @param userId
	 * @param playId
	 * @return
	 */
	public boolean removeFromLibrary(int userId, int playId) {
		Connection conn = connect();
		
		String sql = "DELETE FROM `theatralia`.`userplay` WHERE `userId` = "+userId+" AND `playId` = "+playId+";";
		System.out.println(sql);
		try {
			conn.createStatement().executeUpdate(sql);
			done();
			return true;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		done();
		return false;
	}

	/**
	 * Devuelve un ResultSet con la lista de plays_ids de la Biblioteca para el usuario loggeado 
	 * @param userId
	 * @return ResultSet o Null si falla
	 */
	public ResultSet playsInThisLibrary(int userId) {
		Connection conn = connect();
		String sql = "SELECT playId FROM userplay WHERE `userId` = "+userId+";";
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
		return null;
	}
	
	/**
	 * Devuelve un Resultset de Users cuyo nombre, apellido o userName concuerde con la lista de palabras
	 * que recibe como parametro
	 * @param words
	 * @return rs
	 */
	public ResultSet getUsersBySearch(String[] words) {
		Connection conn = connect();
		String sql = "SELECT U.`userId`, U.`userName`, U.`name`, U.`lastName`, U.`status`, U.`email`, U.`created`, U.`profImage`, R.`description`\r\n" + 
				"FROM `user` U INNER JOIN `userrole` UR ON U.`userId` = UR.`userId`\r\n" + 
				"INNER JOIN `role` R ON UR.`roleId` = R.`roleId`\r\n" + 
				"WHERE U.`status` = 1 AND (" ;
		
		for(String s : words) {
			sql += "U.`userName` LIKE '%"+s+"%' OR U.`name` LIKE '%"+s+"%' OR U.`lastName` LIKE '%"+s+"%' OR ";
		}
		sql = sql.substring(0, sql.length()-4);
		sql += ");";
		System.out.println(sql);
		
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;		
	}

	/**
	 * Devuelve lo que contenga profImage en la tabla user
	 * @param userId
	 * @return el string en profImage o NULL
	 */
	public String getImageById(int userId) {
		Connection conn = connect();
		String sql = "SELECT profImage FROM user WHERE `userId` = "+userId+";";
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			while(rs.next()) {
				String image = rs.getString(1);
				done();
				return image;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
		return null;
	}
}
