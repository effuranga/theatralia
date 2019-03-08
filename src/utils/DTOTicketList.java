package utils;

public class DTOTicketList extends DTODeliveryTable {
	
	private int total;
	private int cantSeats;
	private boolean isClient;
	
	public DTOTicketList(int ticketId, int playId, int cardId, int clientId, int showId, String playName,
			String showDate, String userName, String userLastName, String cardNumber, boolean isPaid,
			String deliveryCode, String buyingDate, int total, int cantSeats, boolean isClient) {
		
		super(ticketId, playId, cardId, clientId, showId, playName, showDate, userName, userLastName, cardNumber, isPaid,
			deliveryCode, buyingDate);
		this.total = total;
		this.cantSeats = cantSeats;	
		this.isClient = isClient;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCantSeats() {
		return cantSeats;
	}

	public void setCantSeats(int cantSeats) {
		this.cantSeats = cantSeats;
	}

	public boolean isClient() {
		return isClient;
	}

	public void setClient(boolean isClient) {
		this.isClient = isClient;
	}
	
	
}
