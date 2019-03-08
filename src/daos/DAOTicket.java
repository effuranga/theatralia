package daos;

import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import business.Seat;
import utils.DTODeliveryTable;
import utils.DTOPurchase;
import utils.DTOSell;

public class DAOTicket extends DAO {
	
	/**
	 * @param ticketId
	 * @return String buyingDate o NULL si el ticket no existe, porque buyingDate IS NOT NULL
	 */
	public String getBuyingDate(int ticketId) {
		Connection conn = connect();
		String sql = "SELECT buyingDate FROM ticket T WHERE T.`ticketId` ="+ticketId+";";
		
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			if(rs.next()) {		
				String buyingDate =  rs.getString(1);
				done();
				
				return buyingDate;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
		return null;
	}
	
	/**
	 * @param ticketId
	 * @return String deliveryCode o NULL
	 */
	public String getDeliveryCode(int ticketId) {
		Connection conn = connect();
		String sql = "SELECT deliveryCode FROM ticket T WHERE T.`ticketId` ="+ticketId+";";
		
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			if(rs.next()) {
				String deliveryCode =  rs.getString(1);
				done();
				
				return deliveryCode;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		done();
		return null;
	}
	
	/**
	 * VENTA: Impacta a Ticket y a TicketShowSeat
	 * @param DTOPurchase
	 * @return el ID del ticket recien creado, sino 0
	 */
	public int createTicket(DTOSell dto) {
		Connection conn = connect();
		String sql = "";
		
		//Campos que necesito para Ticket
		int userId, showId, status;
		String showDate, buyingDate;
		
		userId = dto.getUser().getUserId();
		showId = dto.getShow().getId();
		showDate = dto.getShow().getDate();
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		buyingDate = format.format(new Date()); //Fecha y hora actuales parseadas en formato sql
		
		status = 1; //delivered, por venta en ventanilla

		
		//Inserto el ticket en Ticket y recupero el id
		PreparedStatement statement;
		int affectedRows;
		ResultSet rs;
		int ticketId = 0;
		try {
			sql= "INSERT INTO `theatralia`.`ticket` (`userId`, `showId`, `showDate`, `buyingDate`, `status`, `isPaid`) VALUES ("+userId+", "+showId+", \""+showDate+"\", \""+buyingDate+"\", "+status+", 1);";
System.out.println(sql);
			statement = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			affectedRows = statement.executeUpdate();
			
			if(affectedRows == 0) {
				done();
				return 0;
			}
			
			rs = statement.getGeneratedKeys();

			if(rs.next()) {
				System.out.print("ID es= ");System.out.print(rs.getInt(1));
				ticketId = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Fallo el INSERT en Ticket");
			done();
			return 0;
		}

		//Inserto un row por cada asiento que tiene el ticket en TicketShowSeat
		ArrayList<Seat> seats = dto.getSeats();
		try {
			for(Seat s : seats) {
				sql= "INSERT INTO `theatralia`.`ticketshowseat` (`ticketId`, `showSeatId`) VALUES ("+ticketId+", "+s.getId()+");";
System.out.println(sql);
				statement = conn.prepareStatement(sql);
				statement.executeUpdate();
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Fallo el INSERT en TicketShowSeat");
			done();
			return 0;
		}	
		
		done();
		return ticketId;
	}
	
	/**
	 * COMPRA: Impacta a Ticket y a TicketShowSeat
	 * @param DTOPurchase
	 * @return el ID del ticket recien creado, sino 0
	 */
	public int createTicket(DTOPurchase dto) {
		Connection conn = connect();
		String sql = "";
		
		//Campos que necesito para Ticket
		int userId, showId, cardId, status, isPaid;
		String showDate, buyingDate, deliveryCode;
		
		userId = dto.getUser().getUserId();
		showId = dto.getShow().getId();
		showDate = dto.getShow().getDate();
		cardId = dto.getCard().getId();
		isPaid = (dto.isPayWithCard())? 1 : 0;	//Si ya se pagó, se facturó a la tarjeta, entonces es 1. Sino es 0 y se paga en persona
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		buyingDate = format.format(new Date()); //Fecha y hora actuales parseadas en formato sql
		
		status = 0; //not delivered, por defecto - SO FAR este metodo se usa solo por compra web del usuario, y no por venta
		deliveryCode = generateRandomString(6);
		
		
		//Inserto el ticket en Ticket y recupero el id
		PreparedStatement statement;
		int affectedRows;
		ResultSet rs;
		int ticketId = 0;
		try {
			sql= "INSERT INTO `theatralia`.`ticket` (`userId`, `showId`, `showDate`, `cardId`, `buyingDate`, `status`, `deliveryCode`, `isPaid`) VALUES ("+userId+", "+showId+", \""+showDate+"\", "+cardId+", \""+buyingDate+"\", "+status+", \""+deliveryCode+"\", "+isPaid+");";
System.out.println(sql);
			statement = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
			affectedRows = statement.executeUpdate();
			
			if(affectedRows == 0) {
				done();
				return 0;
			}
			
			rs = statement.getGeneratedKeys();

			if(rs.next()) {
				System.out.print("ID es= ");System.out.print(rs.getInt(1));
				ticketId = rs.getInt(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Fallo el INSERT en Ticket");
			done();
			return 0;
		}

		//Inserto un row por cada asiento que tiene el ticket en TicketShowSeat
		ArrayList<Seat> seats = dto.getSeats();
		try {
			for(Seat s : seats) {
				sql= "INSERT INTO `theatralia`.`ticketshowseat` (`ticketId`, `showSeatId`) VALUES ("+ticketId+", "+s.getId()+");";
System.out.println(sql);
				statement = conn.prepareStatement(sql);
				statement.executeUpdate();
			}
		} catch(SQLException e) {
			e.printStackTrace();
			System.out.println("Fallo el INSERT en TicketShowSeat");
			done();
			return 0;
		}	
		
		done();
		return ticketId;
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

	/**
	 * Devuelve un ResultSet con los ids de los tickets not delivered
	 * @return rs
	 */
	/*
	public ResultSet getTicketsIdsForDelivery() {
		Connection conn = connect();
				
		String qry = "SELECT ticketId FROM `ticket` WHERE `status` = 0";
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
*/
	/**
	 * Devuelve * de la row en Ticket segun id, mas el playID del ticket
	 * @param ticketId
	 * @return
	 */
	public ResultSet getRow(int ticketId) {
		Connection conn = connect();
		
		String qry = "SELECT T.*, S.`playId` FROM `ticket` T INNER JOIN `show` S ON T.`showId` = S.`showId` WHERE `ticketId` = "+ticketId+";";
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
	 * Devuelve un arreglo de IDs de los seats del ticket
	 * @param ticketId
	 * @return ids
	 */
	public ArrayList<String> getSeatsIds(int ticketId) {
		Connection conn = connect();
		ArrayList<String> ids = new ArrayList<String>();
		String qry = "SELECT showSeatId FROM `ticketshowseat` WHERE `ticketId` = "+ticketId+";";
		System.out.println(qry);
		try {
			PreparedStatement ps = conn.prepareStatement(qry);
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				ids.add(rs.getString(1));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		done();
		return ids;
	}

	/**
	 * Devuelve un RS con la información para crear cada DTODeliveryTable
	 * @return rs
	 */
	public ResultSet getDeliveryTableRows() {
		Connection conn = connect();
		
		String qry = "SELECT T.`ticketId`, P.`name` AS \"playName\", P.`playId`, S.`date` AS \"showDate\", S.`showId`, U.`name` AS \"userName\", U.`lastName` AS \"userLastName\", U.`userId`, C.`cardId`, C.`number` AS \"cardNumber\", T.`isPaid`, T.`deliveryCode`, T.`buyingDate` \r\n" + 
				"FROM `ticket` T INNER JOIN `show` S ON T.`showId` = S.`showId` \r\n" + 
				"INNER JOIN `play` P ON S.`playId` = P.`playId`\r\n" + 
				"INNER JOIN `user` U ON T.`userId` = U.`userId`\r\n" + 
				"INNER JOIN `card` C ON T.`cardId` = C.`cardId`\r\n" + 
				"WHERE T.`status` = 0 AND cast(T.`showDate` as date) >= cast(now() as date)";
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
	 * Devuelve los datos para mostrar los tickets de un show particular
	 * @return resultset o null
	 */
	public ResultSet getTicketsTableRows(int showId) {
		Connection conn = connect();
		
		String qry = "SELECT T.`ticketId`, P.`name` AS \"playName\", P.`playId`, S.`date` AS \"showDate\", S.`showId`, U.`name` AS \"userName\", U.`lastName` AS \"userLastName\", U.`userId`, C.`cardId`, C.`number` AS \"cardNumber\", T.`isPaid`, T.`deliveryCode`, T.`buyingDate`, TOTAL.`total` AS \"total\", CANT.cant as \"cant\", UR.`roleId` as \"rol\"\r\n" + 
				"FROM `ticket` T INNER JOIN `show` S ON T.`showId` = S.`showId`\r\n" + 
				"INNER JOIN `play` P ON S.`playId` = P.`playId`\r\n" + 
				"INNER JOIN `user` U ON T.`userId` = U.`userId` \r\n" + 
				"INNER JOIN userrole UR ON U.`userId` = UR.`userId` \r\n" + 
				"LEFT JOIN `card` C ON T.`cardId` = C.`cardId`\r\n" + 
				"INNER JOIN (\r\n" + 
				"  -- Ticket total\r\n" + 
				"  SELECT T.`ticketId`, sum(SS.`price`) AS \"total\"\r\n" + 
				"  FROM `ticket` T INNER JOIN `ticketshowseat` TSS ON T.`ticketId` = TSS.`ticketId`\r\n" + 
				"  INNER JOIN showseat SS ON TSS.`showSeatId` = SS.`showSeatId`\r\n" + 
				"  group by 1\r\n" + 
				"  ) TOTAL ON T.`ticketId` = TOTAL.`ticketId`\r\n" + 
				"INNER JOIN (\r\n" + 
				"  -- Cantidad de asientos\r\n" + 
				"  SELECT TSS.`ticketId`, count(*) AS \"cant\"\r\n" + 
				"  FROM `ticketshowseat` TSS \r\n" + 
				"  group by 1\r\n" + 
				"  ) CANT ON T.`ticketId` = CANT.`ticketId`\r\n" + 
				"WHERE T.`showId` ="+showId+";";
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
	 * Cambia el isPaid del ticket a 1 y crea un registro en la tabla deskCash para trackear el cobro
	 * @param ticketId
	 * @return
	 */
	public boolean payTicketInDesk(int ticketId, int userId) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`ticket` SET `isPaid` = 1 WHERE `ticketId` = "+ticketId+";"; 
		System.out.println(sql);
		try {
			int affectedRows = conn.createStatement().executeUpdate(sql);
			if(affectedRows != 0) {
				sql = "INSERT INTO `theatralia`.`deskcash` (`ticketId`, `userId`) VALUES ("+ticketId+", "+userId+");";
				System.out.println(sql);
				affectedRows = conn.createStatement().executeUpdate(sql);
				if(affectedRows != 0) {
					return true;
				}			
			}
		} catch (SQLException e) {
			done();
			e.printStackTrace();
		}
		return false;	
	}
	
	/**
	 * Cambia el status del ticket a 1 y crea un registro en la tabla delivery para trackear la entrega
	 * @param ticketId
	 * @return
	 */
	public boolean changeTicketStatus(int ticketId, int userId) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`ticket` SET `status` = 1 WHERE `ticketId` = "+ticketId+";"; 
		System.out.println(sql);
		try {
			int affectedRows = conn.createStatement().executeUpdate(sql);
			if(affectedRows != 0) {
				sql = "INSERT INTO `theatralia`.`delivery` (`ticketId`, `userId`) VALUES ("+ticketId+", "+userId+");";
				System.out.println(sql);
				affectedRows = conn.createStatement().executeUpdate(sql);
				if(affectedRows != 0) {
					return true;
				}			
			}
		} catch (SQLException e) {
			done();
			e.printStackTrace();
		}
		return false;	
	}

	/**
	 * Devuelve un RS con la información para crear cada DTOExpiredTable
	 * @return rs
	 */
	public ResultSet getExpiredTableRows() {
		Connection conn = connect();
		
		String qry = "SELECT T.`ticketId`, P.`name` AS \"playName\", P.`playId`, S.`date` AS \"showDate\", S.`showId`, U.`name` AS \"userName\", U.`lastName` AS \"userLastName\", U.`userId`, C.`cardId`, C.`number` AS \"cardNumber\", T.`isPaid`, T.`deliveryCode`, T.`buyingDate` \r\n" + 
				"FROM `ticket` T INNER JOIN `show` S ON T.`showId` = S.`showId` \r\n" + 
				"INNER JOIN `play` P ON S.`playId` = P.`playId`\r\n" + 
				"INNER JOIN `user` U ON T.`userId` = U.`userId`\r\n" + 
				"INNER JOIN `card` C ON T.`cardId` = C.`cardId`\r\n" + 
				"WHERE T.`status` = 0 AND cast(T.`showDate` as date) < cast(now() as date)";
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
	 * Este metodo cambia isPaid del ticket a 1 (paid) y agrega un record en la tabla chargedCard
	 * @param ticketId
	 * @param userId
	 * @return
	 */
	public boolean payTicketByChargingInCard(int ticketId, int userId) {
		Connection conn = connect();
		String sql = "UPDATE `theatralia`.`ticket` SET `isPaid` = 1 WHERE `ticketId` = "+ticketId+";"; 
		System.out.println(sql);
		try {
			int affectedRows = conn.createStatement().executeUpdate(sql);
			if(affectedRows != 0) {
				sql = "INSERT INTO `theatralia`.`chargedcard` (`ticketId`, `userId`) VALUES ("+ticketId+", "+userId+");";
				System.out.println(sql);
				affectedRows = conn.createStatement().executeUpdate(sql);
				if(affectedRows != 0) {
					return true;
				}			
			}
		} catch (SQLException e) {
			done();
			e.printStackTrace();
		}
		return false;	
	}

	/**
	 * Este metodo cambia el isPaid del ticket a 1 (paid) y agrega un record en la tabla chargedCard
	 * PARA CADA TICKET que SEA VIEJO y que NO ESTE PAGO
	 * @return
	 */
	public boolean chargeAllCards(ArrayList<DTODeliveryTable> rows) {
		Connection conn = connect();
		String list = createListOfIDs(rows);
		String sql = "UPDATE `theatralia`.`ticket` SET `isPaid` = 1 WHERE `ticketId` IN ("+list+");";
		System.out.println(sql);
		try {
			int affectedRows = conn.createStatement().executeUpdate(sql);
			if(affectedRows != 0) {
				for(DTODeliveryTable r : rows) {
					sql = "INSERT INTO `theatralia`.`chargedcard` (`ticketId`, `userId`) VALUES ("+r.getTicketId()+", "+r.getClientId()+");";
					System.out.println(sql);
					conn.createStatement().executeUpdate(sql);
				}
				done();
				return true;
			}
		} catch (SQLException e) {	
			e.printStackTrace();
		}
		done();
		return false;	
	}
	
	private String createListOfIDs(ArrayList<DTODeliveryTable> rows) {
		String list ="";	
		int size = rows.size();
		
		for(int i = 0; i<size-1; i++) {
			list += rows.get(i).getTicketId()+",";
		}
		list += rows.get(size-1).getTicketId();
		
		return list;
	}

	public ResultSet getDTOMyTicketsList(int userId) {
		Connection conn = connect();
		
		String qry = "SELECT T.*, P.`playId`, P.`name`, C.`number` AS cardNumber\r\n" + 
				"FROM ticket T INNER JOIN `show` S ON T.`showId` = `S`.`showId` \r\n" + 
				"INNER JOIN play P ON S.`playId` = P.`playId`\r\n" + 
				"INNER JOIN card C ON T.`cardId` = C.`cardId`\r\n" + 
				"WHERE T.`userId` = "+userId+";";
		
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
