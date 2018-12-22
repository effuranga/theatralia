package utils;

import business.Play;
import business.Seat;
import business.Show;
import business.User;

import java.util.ArrayList;

import business.Card;


public class DTOPurchase {
	private Play play;
	private Show show;
	private int cantSeats;
	private boolean payWithCard;
	private Card card;
	private ArrayList<Seat> seats;
	private User user;

	public boolean isFit() {
		if(play != null && show != null && card != null && !seats.isEmpty() && show.getStatus() == 1) {
			return true;
		}
		
		return false;
	}

	
	public DTOPurchase(Play play, User user) {
		super();
		this.user = user;
		this.play = play;
		this.seats = new ArrayList<Seat>();
		this.payWithCard = true;
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
	public boolean isPayWithCard() {
		return payWithCard;
	}
	public void setPayWithCard(boolean payWithCard) {
		this.payWithCard = payWithCard;
	}
	public int getCantSeats() {
		return cantSeats;
	}
	public void setCantSeats(int cantSeats) {
		this.cantSeats = cantSeats;
	}
	public Card getCard() {
		return card;
	}
	public void setCard(Card card) {
		this.card = card;
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
