package utils;



public class DTODescriptionExtension {
	private int playId;
	private int showId;
	private String showDate;
	private String price;
	private int availableSeats;
	public DTODescriptionExtension(int playId, int showId, String showDate, String price, int availableSeats) {
		super();
		this.playId = playId;
		this.showId = showId;
		this.showDate = showDate;
		this.price = price;
		this.availableSeats = availableSeats;
	}
	
	public int getPlayId() {
		return playId;
	}
	public void setPlayId(int playId) {
		this.playId = playId;
	}
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public int getAvailableSeats() {
		return availableSeats;
	}
	public void setAvailableSeats(int availableSeats) {
		this.availableSeats = availableSeats;
	}
	
	


}
