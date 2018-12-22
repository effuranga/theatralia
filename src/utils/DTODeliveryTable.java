package utils;

public class DTODeliveryTable {
	private int ticketId;
	private int playId;
	private int cardId;
	private int clientId;
	private int showId;
	private String playName;
	private String showDate;
	private String userName;
	private String userLastName;
	private String cardNumber;
	private boolean isPaid;
	private String deliveryCode;
	private String buyingDate;
	
	public DTODeliveryTable(int ticketId, int playId, int cardId, int clientId, int showId, String playName,
			String showDate, String userName, String userLastName, String cardNumber, boolean isPaid,
			String deliveryCode, String buyingDate) {
		super();
		this.ticketId = ticketId;
		this.playId = playId;
		this.cardId = cardId;
		this.clientId = clientId;
		this.showId = showId;
		this.playName = playName;
		this.showDate = showDate;
		this.userName = userName;
		this.userLastName = userLastName;
		this.cardNumber = cardNumber;
		this.isPaid = isPaid;
		this.deliveryCode = deliveryCode;
		this.buyingDate = buyingDate;
	}

	public int getTicketId() {
		return ticketId;
	}

	public void setTicketId(int ticketId) {
		this.ticketId = ticketId;
	}

	public int getPlayId() {
		return playId;
	}

	public void setPlayId(int playId) {
		this.playId = playId;
	}

	public int getCardId() {
		return cardId;
	}

	public void setCardId(int cardId) {
		this.cardId = cardId;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}

	public int getShowId() {
		return showId;
	}

	public void setShowId(int showId) {
		this.showId = showId;
	}

	public String getPlayName() {
		return playName;
	}

	public void setPlayName(String playName) {
		this.playName = playName;
	}

	public String getShowDate() {
		return showDate;
	}

	public void setShowDate(String showDate) {
		this.showDate = showDate;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserLastName() {
		return userLastName;
	}

	public void setUserLastName(String userLastName) {
		this.userLastName = userLastName;
	}

	public String getCardNumber() {
		return cardNumber;
	}

	public void setCardNumber(String cardNumber) {
		this.cardNumber = cardNumber;
	}

	public boolean isPaid() {
		return isPaid;
	}

	public void setPaid(boolean isPaid) {
		this.isPaid = isPaid;
	}

	public String getDeliveryCode() {
		return deliveryCode;
	}

	public void setDeliveryCode(String deliveryCode) {
		this.deliveryCode = deliveryCode;
	}

	public String getBuyingDate() {
		return buyingDate;
	}

	public void setBuyingDate(String buyingDate) {
		this.buyingDate = buyingDate;
	}
	
	
	
}
