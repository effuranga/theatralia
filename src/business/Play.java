package business;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * @author Eff
 *
 */
public class Play {
	private int id;
	private String name;
	private String description;
	private String author;
	private int status;
	private int starred;
	private String image;
	private ArrayList<Show> shows;
	private String created;
	
	
	//Constructors	
	public Play(int id, String name, String description, String author, int status, String image) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.author = author;
		this.status = status;
		this.image = image;
		this.shows = new ArrayList<Show>();
	}
	
	public Play(int id, String name, String description, String author, int status, String image, int starred, String created) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.author = author;
		this.status = status;
		this.image = image;
		this.starred = starred;
		this.created = created;
		this.shows = new ArrayList<Show>();
	}

	public Play(int id, String name, String author, String image) {
		super();
		this.id = id;
		this.name = name;
		this.author = author;
		this.image = image;
		this.shows = new ArrayList<Show>();
	}


	public Play(int playId) {
		super();
		this.id = playId;
		this.shows = new ArrayList<Show>();
	}

	public void addShow(Show show) {
		this.shows.add(show);
	}
	
	//Getters and Setters
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public int  getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}

	public ArrayList<Show> getShows() {
		return shows;
	}

	public void setShows(ArrayList<Show> shows) {
		this.shows = shows;
	}

	public int getStarred() {
		return starred;
	}

	public void setStarred(int starred) {
		this.starred = starred;
	}

	public String getCreated() {
		return created;
	}

	public void setCreated(String created) {
		this.created = created;
	}

	/**
	 * Remueve de la obra los shows en estado 0 (SIN ASIENTOS LIBRES)
	 */
	public void removeShowsWithNoSeatsLeft() {
		Iterator<Show> i = this.shows.iterator();
		while(i.hasNext()) {
			Show s = i.next();
			if(!s.hasSeatsAvailable()) {
				i.remove();
			}
		}
	}
	
	/**
	 * Checkea si dentro de los shows que tenga la obra hay alguno de hoy o en el futuro
	 * @return
	 */
	public boolean hasShowsInTheFuture() {
		for(Show s : this.shows) {
			if(s.isAFutureShow()) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Remueve de la obra los shows con fechas menores a hoy
	 */
	public void removeShowsFromThePast() {
		Iterator<Show> i = this.shows.iterator();
		while(i.hasNext()) {
			Show s = i.next();
			if(!s.isAFutureShow()) {
				i.remove();
			}
		}
		
	}
	
	
	
}
