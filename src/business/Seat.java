package business;

public class Seat {
	private float price;
	private int id;
	private String description;
	private int status;
	
	public Seat(int id, float price) {
		super();
		this.setId(id);
		this.price = price;
	}
	
	public Seat(int id, float price, int status) {
		super();
		this.setId(id);
		this.price = price;
		this.status = status;
	}
	
	public float getPrice() {
		return price;
	}
	public void setPrice(float price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	
}
