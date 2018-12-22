package daos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DAOCard extends DAO {
	
	/**
	 * Devuelve un resultset con las cards EN ESTADO 1 - available - para un usuario por su ID
	 * @param userId
	 * @return
	 */
	public ResultSet getCardsByUserID(int userId) {
		Connection conn = connect();
		String sql = "SELECT * FROM `card` WhERE `userId` = " + userId + " AND status = 1;"; 
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	/**
	 * Devuelve un resultset con la card que matchee con el id
	 * @param userId
	 * @return
	 */
	public ResultSet getCard(int cardId) {
		Connection conn = connect();
		String sql = "SELECT * FROM `card` WhERE `cardId` = " + cardId + " AND status = 1;"; 
		System.out.println(sql);
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	public boolean saveCard(String type, String number, String name, String description, String exp_month, String exp_year, int userId) {
		Connection conn = connect();
		String sql = "INSERT INTO `card` ( `userId`, `number`, `description`, `name`, `type`, `exp_year`, `exp_month`) \r\n" + 
				"VALUE ("+userId+", \""+number+"\", "+description+", \""+name+"\", \""+type+"\", "+exp_year+", "+exp_month+");";
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
	
	public boolean deleteCard(int userId, String cardId) {
		Connection conn = connect();
		String sql = "update card set status = 0 where userId = "+userId+" AND cardId = "+cardId+";";
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
}
