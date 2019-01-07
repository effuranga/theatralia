package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import business.Play;
import business.Seat;
import business.Show;
import daos.DAOSeat;

public class SeatHandler {
	
	//TODO checkear este metodo porque debe andar para la mierda HAY QUE VER BIEN COMO ARMAR EL SEAT PARA ORDENARLO DESP EN FE
	/**
	 * Toma la obra que ya tiene los shows creados, y busca para cada show crear sus asientos con precios (ID de ShowSeat, Precio y Status)
	 * @param play
	 */
	public void fillShowsWithSeats(Play play) {
		ArrayList<Show> shows = play.getShows();
		ResultSet rs;
		DAOSeat daoSeat = new DAOSeat();
		int showId, seatId, status, column;
		String row;
		float price;
		Seat seat;
		for(Show s : shows) {
			showId = s.getId();
			rs = daoSeat.getSeatsForShow(showId);
			try {
				while(rs.next()) {
					seatId = rs.getInt(1);
					price = rs.getFloat(2);
					status = rs.getInt(3);
					row = rs.getString(4);
					column = rs.getInt(5);
					seat = new Seat(seatId, price, status, row, column);
					s.addSeat(seat);
				
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			daoSeat.done();
		}
	}

	/**
	 * Devuelve un seat segun su id en ShowSeat
	 * @param id
	 * @return new Seat o null
	 */
	public Seat getSeat(String id) {
		DAOSeat daoSeat = new DAOSeat();
		ResultSet rs = daoSeat.getSeat(id);
			try {
				if(rs.next()) {
					int seatId = Integer.parseInt(id);
					float price = rs.getFloat(1);
					int status = rs.getInt(2);
					String row = rs.getString(3);
					int column = rs.getInt(4);
					daoSeat.done();
					return (new Seat(seatId, price, status, row, column));
				
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		daoSeat.done();
		return null;
		}
}
