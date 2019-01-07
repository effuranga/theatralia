package business;

public class Seat {
	private float price;
	private int id;
	private String description;
	private int status;
	private String row;
	private int column;
	
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
	
	public Seat(int id, float price, int status, String row, int column) {
		super();
		this.setId(id);
		this.price = price;
		this.status = status;
		this.row = row;
		this.column = column;
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

	public String getRow() {
		return row;
	}

	public void setRow(String row) {
		this.row = row;
	}

	public int getColumn() {
		return column;
	}

	public void setColumn(int column) {
		this.column = column;
	}
	
	
	
	
}
