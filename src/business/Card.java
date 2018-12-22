package business;

public class Card {
	private int id;
	private String number, name, type;
	private int status, exp_year, exp_month;
	private String description;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}	
	public int getExp_year() {
		return exp_year;
	}
	public void setExp_year(int exp_day) {
		this.exp_year = exp_day;
	}
	public int getExp_month() {
		return exp_month;
	}
	public void setExp_month(int exp_month) {
		this.exp_month = exp_month;
	}
	public Card(int id, String number, int status, String description, String name, String type, int exp_year, int exp_month) {
		super();
		this.id = id;
		this.number = number;
		this.status = status;
		this.description = description;
		this.name = name;
		this.type = type;
		this.exp_year = exp_year;
		this.exp_month = exp_month;
	}
	public Card(int id) {
		super();
		this.id = id;
	}
	
	
}
