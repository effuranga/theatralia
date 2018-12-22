package daos;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import business.Seat;

public class DAOSeat extends DAO {

	/**
	 * Devuelve el id, el precio y el status de los asientos de un determinado show
	 * @param idShow
	 * @return
	 */
	public ResultSet getSeatsForShow(int idShow) {
		Connection conn = connect();
		String sql="SELECT distinct SS.showSeatId, SS.price, SS.status FROM theatralia.`show` S INNER JOIN theatralia.showseat SS\r\n" + 
				"ON S.showId = SS.showId\r\n" + 
				"WHERE S.showId = "+idShow+";";
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

	/**
	 * Impacta sobre la tabla ShowSeats ocupando los asientos del DTO (DTOPurchase o DTOSell)
	 * @param ArrayList<Seat> seats
	 * @return
	 */
	public boolean occupySeats(ArrayList<Seat> seats) {
		Connection conn = connect();

		String seatsIds = createListOfIDs(seats);
		String sql="UPDATE `theatralia`.`showseat` SET `status` = 1 WHERE `showSeatId` IN ("+seatsIds+"); ";
System.out.println(sql);
		try {
			conn.prepareStatement(sql).executeUpdate();
			done();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			done();
			return false;
		}
	}
	
	/**
	 * Genera la lista dentro de la clausula IN con los IDs de los asientos, todos con coma menos el último
	 * @param seats
	 * @return
	 */
	private String createListOfIDs(ArrayList<Seat> seats) {
		String list ="";	
		int size = seats.size();
		
		for(int i = 0; i<size-1; i++) {
			list += seats.get(i).getId()+",";
		}
		list += seats.get(size-1).getId();
		
		return list;
	}

	public ResultSet getSeat(String id) {
		Connection conn = connect();
		String sql="SELECT SS.price, SS.status "
				+ "FROM theatralia.showseat SS\r\n" + 
				"WHERE SS.showSeatId = "+id+";";
		try {
			ResultSet rs = conn.prepareStatement(sql).executeQuery();
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
