package utils;

import business.Play;
import business.Seat;
import business.Show;
import business.User;

import java.util.ArrayList;

public class DTOSell {
	private Play play;
	private Show show;
	private ArrayList<Seat> seats;
	private User user;

	public boolean isFit() {
		if(play != null && show != null && !seats.isEmpty() && user != null) {
			return true;
		}
		return false;
	}

	
	public DTOSell(Play play, User user, Show show) {
		super();
		this.user = user;
		this.play = play;
		this.show = show;
		this.seats = new ArrayList<Seat>();
	}
	public Play getPlay() {
		return play;
	}
	public void setPlay(Play play) {
		this.play = play;
	}
	public Show getShow() {
		return show;
	}
	public void setShow(Show show) {
		this.show = show;
	}
	public ArrayList<Seat> getSeats() {
		return seats;
	}
	public void setSeats(ArrayList<Seat> seats) {
		this.seats = seats;
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}
	
	

}
