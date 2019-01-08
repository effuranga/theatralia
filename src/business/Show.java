package business;

import java.util.ArrayList;

import utils.DateHandler;

public class Show {
	private int id;
	private String date = "";
	private int status;
	private ArrayList<Seat> seats;
	
	public Show(int id, String date, int status) {
		super();
		this.setId(id);
		this.date = date;
		this.status = status;
		this.seats = new ArrayList<Seat>();
	}
	
	public Show(int showId) {
		super();
		this.id = showId;
		
		this.seats = new ArrayList<Seat>();
	}

	public void addSeat(Seat seat) {
		this.seats.add(seat);
	}
	
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	public ArrayList<Seat> getSeats() {
		return seats;
	}

	public void setSeats(ArrayList<Seat> seats) {
		this.seats = seats;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	/**
	 * Deriva el status del show, si no le quedan asientos libres devuelve false
	 * @return true si tiene algun asiento libre, false si todos los asientos estan comprados
	 */
	public boolean hasSeatsAvailable() {
		for(Seat s : seats) {
			if(s.getStatus() == 0) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Valida si la fecha del show es la de hoy o posterior
	 * @return
	 */
	public boolean isAFutureShow() {
		DateHandler dateHandler = new DateHandler();
		return dateHandler.isAFutureDate(this.date);
	}
	
	/**
	 * Devuelve la cantidad de asientos vacios que tiene el show
	 * @return
	 */
	public int countSeatsAvailable() {
		int cant = 0;
		for(Seat s : this.seats) {
			if(s.getStatus() == 0) {
				cant++;
			}
		}
		return cant;
	}
	
	
}
