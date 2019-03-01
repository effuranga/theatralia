package utils;

public class DTOMyTickets {
	private int ticketId;
	private String showDate;
	private String buyingDate;
	private boolean isDelivered;
	private boolean isPaid;
	private String deliveryCode;
	private int playId;
	private String playName;
	private String cardNumber;
	
	
	
	public DTOMyTickets(int ticketId, String showDate, String buyingDate, int isDelivered, int isPaid,
			String deliveryCode, int playId, String playName, String cardNumber) {
		super();
		this.ticketId = ticketId;
		this.showDate = showDate;
		this.buyingDate = buyingDate;
		this.deliveryCode = deliveryCode;
		this.playId = playId;
		this.playName = playName;
		this.setPaid(isPaid);
		this.setDelivered(isDelivered);
		this.cardNumber = cardNumber;
		
	}
	public int getTicketId() {
		return ticketId;
	}
	public void setTicketId(int ticketId) {
		this.ticketId = ticketId;
	}
	public String getShowDate() {
		return showDate;
	}
	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}
	public String getBuyingDate() {
		return buyingDate;
	}
	public void setBuyingDate(String buyingDate) {
		this.buyingDate = buyingDate;
	}
	public boolean isDelivered() {
		return isDelivered;
	}
	public void setDelivered(int delivered) {
		this.isDelivered = (delivered == 0)? false : true;
	}
	public boolean isPaid() {
		return isPaid;
	}
	public void setPaid(int paid) {
		this.isPaid = (paid == 0)? false : true;
	}
	public String getDeliveryCode() {
		return deliveryCode;
	}
	public void setDeliveryCode(String deliveryCode) {
		this.deliveryCode = deliveryCode;
	}
	public int getPlayId() {
		return playId;
	}
	public void setPlayId(int playId) {
		this.playId = playId;
	}
	public String getPlayName() {
		return playName;
	}
	public void setPlayName(String playName) {
		this.playName = playName;
	}
	public String getCardNumber() {
		return cardNumber;
	}
	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}
	
	
	
}
