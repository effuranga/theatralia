package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import business.Play;
import business.Show;
import daos.DAOShow;

public class ShowHandler {
	
	/**
	 * Para una obra con su ID, se toma una lista de fechas y se da de alta
	 * un registro por cada show para esa obra, y por cada show, tantos registros 
	 * como asientos se les haya asignado desde los cargados en la tabla seat, para showseat
	 * @param id
	 * @param datesList
	 * @return
	 */
	public boolean createShowsForPlay(int id, ArrayList<String> datesList, int price){
		if(datesList == null || datesList.isEmpty()) {
			return false;
		}
		for(String s: datesList) {
			System.out.println(s);
		}	
		DAOShow daoShow = new DAOShow();	
		boolean success = daoShow.createShowsForPlay(id, datesList, price);	
		
		return success;
	}
	
	/**
	 * Recibe la obra y la llena de shows TODOS y cada show de sus asientos 
	 * @param play
	 */
	public void fillWithShows(Play play) {
		DAOShow daoShow = new DAOShow();
		ResultSet rs = daoShow.getShowsForPlay(play.getId());
			
		try {
			if(rs != null && rs.next()) {
				rs.beforeFirst();
				while(rs.next()) {
					Show show = new Show(rs.getInt(1), rs.getString(2), rs.getInt(3));
					play.addShow(show);
					
				}
				daoShow.done();
				//Hasta aca llene la obra de Shows basicos, tengo que llenarla de Seats
				if(!play.getShows().isEmpty()) {
					SeatHandler seatHandler = new SeatHandler();
					seatHandler.fillShowsWithSeats(play);
				}		
			}
			else {
				daoShow.done();
			}
		} catch (SQLException e) {			
			e.printStackTrace();
			daoShow.done();
		}		
	}

	public Show locateShow(Play play, int showId) {
		ArrayList<Show> shows = play.getShows();
		for(int i = 0; i < shows.size(); i++) {
			if(shows.get(i).getId() == showId) return shows.get(i);
		}
		return null;
	}
}
