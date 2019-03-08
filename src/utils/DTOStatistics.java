package utils;

public class DTOStatistics {
	private int showId;
	private String showDate;
	private int price;
	private int cantChargedTickets;
	private int cantIssuedTickets;
	private int availableSeats;
	public int getShowId() {
		return showId;
	}
	public void setShowId(int showId) {
		this.showId = showId;
	}
	public String getShowDate() {
		return showDate;
	}
	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getCantChargedTickets() {
		return cantChargedTickets;
	}
	public void setCantChargedTickets(int cantChargedTickets) {
		this.cantChargedTickets = cantChargedTickets;
	}
	public int getCantIssuedTickets() {
		return cantIssuedTickets;
	}
	public void setCantIssuedTickets(int cantIssuedTickets) {
		this.cantIssuedTickets = cantIssuedTickets;
	}
	public int getAvailableSeats() {
		return availableSeats;
	}
	public void setAvailableSeats(int availableSeats) {
		this.availableSeats = availableSeats;
	}
	public DTOStatistics(int showId, String showDate, int price, int cantChargedTickets, int cantIssuedTickets,
			int availableSeats) {
		super();
		this.showId = showId;
		this.showDate = showDate;
		this.price = price;
		this.cantChargedTickets = cantChargedTickets;
		this.cantIssuedTickets = cantIssuedTickets;
		this.availableSeats = availableSeats;
	}
	
}
