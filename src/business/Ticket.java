package business;

import java.util.ArrayList;

import services.TicketHandler;

public class Ticket {
	
	private int id;
	private Play play;
	private Show show;
	private boolean isPaid;
	private boolean isDelivered;
	private Card card;
	private ArrayList<Seat> seats;
	private User user;
	private String buyingDate;
	private String deliveryCode;
	
	public Ticket(int id, Play play, Show show, boolean isPaid, boolean isDelivered, Card card, ArrayList<Seat> seats,
			User user, String buyingDate, String deliveryCode) {
		super();
		this.id = id;
		this.play = play;
		this.show = show;
		this.isPaid = isPaid;
		this.isDelivered = isDelivered;
		this.card = card;
		this.seats = seats;
		this.user = user;
		this.buyingDate = buyingDate;
		this.deliveryCode = deliveryCode;
	}

	public Ticket(int id, Play play, Show show, boolean isPaid, boolean isDelivered, Card card,
			ArrayList<Seat> seats, User user) {
		super();
		this.id = id;
		this.play = play;
		this.show = show;
		this.isPaid = isPaid;
		this.isDelivered = isDelivered;
		this.card = card;
		this.seats = seats;
		this.user = user;
		
		TicketHandler ticketHandler = new TicketHandler();
		this.buyingDate = ticketHandler.getBuyingDate(id);
		this.deliveryCode = ticketHandler.getDeliveryCode(id);
	}
	
	public float getTotal() {
		float total = 0;
		for(Seat s : seats) {
			total += s.getPrice();
		}
		return total;
	}
	
	public String getBuyingDate() {
		return buyingDate;
	}

	public void setBuyingDate(String buyingDate) {
		this.buyingDate = buyingDate;
	}

	public String getDeliveryCode() {
		return deliveryCode;
	}

	public void setDeliveryCode(String deliveryCode) {
		this.deliveryCode = deliveryCode;
	}


	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
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
	public boolean isPaid() {
		return isPaid;
	}
	public void setIsPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}
	public boolean isDelivered() {
		return isDelivered;
	}
	public void setDelivered(boolean isDelivered) {
		this.isDelivered = isDelivered;
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
