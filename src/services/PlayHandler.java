package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import business.Play;
import daos.DAOPlay;

/**
 * Crea Plays y maneja su inforación a nivel de negocio.
 * Obtiene los resultados de la DB desde su DAO
 * @author Eff
 *
 */
public class PlayHandler {
	
	/**
	 * Cambia el status de una obra 
	 * @param playId
	 * @param toStatus
	 * @return true or false
	 */
	public boolean changePlayStatus(int playId, int toStatus) {
		DAOPlay daoPlay = new DAOPlay();
		
		return daoPlay.changePlayStatus(playId, toStatus);
	}
	
	public boolean updatePlay(String id, String name, String description, String author) {
		DAOPlay daoPlay = new DAOPlay();
		boolean updated = daoPlay.updatePlay(id,name, description, author);
		
		return updated;
	}
	
	/**
	 * Este método devuelve las obras que no están hidden
	 * @return HashMap currentPlays
	 */
	public HashMap<Integer, Play> getCurrentPlays(){
		DAOPlay daoPlay = new DAOPlay();
		HashMap<Integer,Play> currentPlays = new HashMap<Integer, Play>();
		//Variables del resultset
		int playId, status;
		String name, description, author, image;
		Play play;
		
		ResultSet rs = daoPlay.getCurrentPlays();
		
		// Logica para convertir el resultSet en el HashMap
		try {
			while(rs.next()) {
				playId = rs.getInt("playId");
				name = rs.getString("name");
				description = rs.getString("description");
				author = rs.getString("author");
				status = rs.getInt("status");
				image = rs.getString("image");
				
				play = new Play(playId, name, description, author, status, image);
				
				currentPlays.put(playId, play);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//Fin de la logica
		daoPlay.done();
		return currentPlays;
	}
	
	/**
	 * Este metodo da de alta una obra en estado 0 (hidden), con su información básica.
	 * @param name
	 * @param description
	 * @param author
	 * @return id - el id en la base de datos de la nueva play creada o 0 si hubo un error
	 */
	public int createPlay(String name, String description, String author){
		DAOPlay daoPlay = new DAOPlay();
		
		int id = daoPlay.createPlay(name, description, author);
		
		return id;
	}
	
	/**
	 * Genera una obra desde el ResultSet que le devuelve el DAOPlay, buscando por ID
	 * @param id
	 * @return Play - si se pudo crear y encuentra algo. Sino NULL
	 */
	public Play getBasicPlay(String id) {
		DAOPlay daoPlay = new DAOPlay();
		ResultSet rs = daoPlay.getBasicPlay(id);
		
		try {
			if(rs.next()) {
				String name = rs.getString("name");
				String author = rs.getString("author");
				String description = rs.getString("description");
				String status = rs.getString("status");
				String image = rs.getString("image");
				
				Play play = new Play(Integer.parseInt(id), name, description, author, Integer.parseInt(status), image);
				
				
				
				daoPlay.done();
				return play;
			}
		} catch (NumberFormatException | SQLException e) {
			e.printStackTrace();
		}
		daoPlay.done();
		return null;
	}
	
	/**
	 * Este método devuelve las obras marcadas como starred para ser mostradas
	 * en la página del home
	 * @return HashMap<String id, Play play> starredPlays
	 */
	public ArrayList<Play> getStarredPlays(){
		DAOPlay daoPlay = new DAOPlay();
		ArrayList<Play> starredPlays = new ArrayList<Play>();
		//Variables del resultset
		int playId;
		String name, author, image;
		Play play;
		
		ResultSet rs = daoPlay.getStarredPlays();
		
		// Logica para convertir el resultSet en el HashMap
		try {
			while(rs.next()) {
				playId = rs.getInt("playId");
				name = rs.getString("name");
				author = rs.getString("author");
				image = rs.getString("image");
				
				play = new Play(playId, name, author, image);
				
				starredPlays.add(play);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//Fin de la logica
		daoPlay.done();
		return starredPlays;

	}
	
	/**
	 * Toma la obra y la llena de shows y sus seats
	 * @param play
	 */
	public void fillWithShows(Play play) {
		ShowHandler showHandler = new ShowHandler();
		showHandler.fillWithShows(play); 
		
	}
	
	public void setImage(int id) {
		DAOPlay daoPlay = new DAOPlay();
		daoPlay.setImage(id);
	}
	
	public void setImage(String id) {
		int idInt = Integer.parseInt(id);
		this.setImage(idInt);
	}
	
	/**
	 * Este metodo devuelve toda la tabla Play
	 * @return
	 */
	public ArrayList<Play> getAllPlays(){
		ArrayList<Play> allPlays = new ArrayList<Play>();
		DAOPlay daoPlay = new DAOPlay();
		ResultSet rs = daoPlay.getAllPlays();
		
		try {
			while(rs.next()) {
				int id = rs.getInt("playId");
				String name = rs.getString("name");
				String description = rs.getString("description");
				String author = rs.getString("author");
				int status = rs.getInt("status");
				String image = rs.getString("image");
				int starred = rs.getInt("starred");
				String created = rs.getString("created");
				Play play = new Play(id, name, description, author, status, image, starred, created);
				allPlays.add(play);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
			
		daoPlay.done();
		return allPlays;
	}
	
	/**
	 * Este metodo crea una obra con todos los registros de la tabla Play 
	 * y todos sus Shows
	 * @param id: el id de la Play
	 * @return Play si el id existe en la tabla Play | NULL si no se encuentra
	 * @throws SQLException 
	 */
	public Play getWholePlay(int id){
		DAOPlay daoPlay = new DAOPlay();
		ResultSet rsPlay = daoPlay.getWholePlay(id);
		if(rsPlay != null) {
			try {
				while(rsPlay.next()) {
					String name = rsPlay.getString("name");
					String description = rsPlay.getString("description");
					String author = rsPlay.getString("author");
					int status = rsPlay.getInt("status");
					String image = rsPlay.getString("image");
					int starred = rsPlay.getInt("starred");
					String created = rsPlay.getString("created");
					
					daoPlay.done();
					
					Play play = new Play(id, name, description, author, status, image, starred, created);
					//Tengo que llenarla de shows y de asientos
					ShowHandler showHandler = new ShowHandler();
					showHandler.fillWithShows(play);
					
					return play;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		daoPlay.done();
		return null;
	}

	public ArrayList<Play> getThesePlays(ArrayList<String> playIdList) {
		DAOPlay daoPlay = new DAOPlay();
		ArrayList<Play> playList = new ArrayList<Play>();
		//Variables del resultset
		int playId, status;
		String name, description, author, image;
		Play play;
		
		ResultSet rs = daoPlay.getThesePlays(playIdList);
		
		// Logica para convertir el resultSet en el HashMap
		try {
			while(rs.next()) {
				playId = rs.getInt("playId");
				name = rs.getString("name");
				description = rs.getString("description");
				author = rs.getString("author");
				status = rs.getInt("status");
				image = rs.getString("image");
				
				play = new Play(playId, name, description, author, status, image);
				
				playList.add(play);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		//Fin de la logica
		daoPlay.done();
		return playList;
	}

	/**
	 * Devuelve un arreglo de Plays cuyo nombre, autor o descripcion concuerde con la lista de palabras
	 * que recibe como parametro
	 * @param words
	 * @return playsResult lleno o vacio
	 */
	public ArrayList<Play> getPlaysBySearch(String[] words) {
		DAOPlay daoPlay = new DAOPlay();
		ArrayList<Play> playsResult = new ArrayList<Play>();
		//Variables del resultset
		int playId, status;
		String name, description, author, image;
		Play play;
		
		ResultSet rs = daoPlay.getPlaysBySearch(words);
		
		// Logica para convertir el resultSet en el HashMap
		try {
			while(rs.next()) {
				playId = rs.getInt("playId");
				name = rs.getString("name");
				description = rs.getString("description");
				author = rs.getString("author");
				status = rs.getInt("status");
				image = rs.getString("image");
				
				play = new Play(playId, name, description, author, status, image);
				
				playsResult.add(play);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		  catch (NullPointerException e) {
			e.printStackTrace();
		  }
		//Fin de la logica
		daoPlay.done();
		return playsResult;
	}
}
