package services;
import business.Card;
import daos.DAOCard;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import services.CardHandler;

public class CardHandler {
	
	/**
	 * Este metodo busca las tarjetas en ESTADO 1 de un usuario por su userId
	 * @param userId
	 * @return ArrayList<Card> lleno de Cards completo, status incluido. Vacio si no tiene ninguna. NUNCA NULL
	 */
	public ArrayList<Card> getCardsByUserID(int userId){
		ArrayList<Card> cardList = new ArrayList<Card>();
		
		DAOCard daoCard = new DAOCard();
		ResultSet rs = daoCard.getCardsByUserID(userId);
		
		String description, number, name, type;
		int cardId, status, exp_year, exp_month;
		
		try {
			while(rs.next()) {
				cardId = rs.getInt("cardId");
				number = rs.getString("number");
				status = rs.getInt("status");
				description = rs.getString("description");
				name = rs.getString("name");
				type = rs.getString("type");
				exp_year = rs.getInt("exp_year");
				exp_month = rs.getInt("exp_month");
				
				cardList.add(new Card(cardId, number, status, description, name, type, exp_year, exp_month));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		daoCard.done();
		return cardList;
	}
	
	public boolean validateNewCardFields(String type, String number, String name, String description, String exp_month, String exp_year) {
		System.out.println("0");
		if(!type.trim().equals("Visa") && !type.trim().equals("Mastercard") && !type.trim().equals("American Express")) return false; System.out.println("1");
		if(!number.matches("[0-9]+")) return false;System.out.println("2");
		if(name.trim().isEmpty()) return false;System.out.println("3");
		try {
			int month = Integer.parseInt(exp_month);
			int year = Integer.parseInt(exp_year);
			if(month<1 || month >12) return false;System.out.println("4");
			if(year<18 || year > 30) return false;System.out.println("5");
		}
		catch(NumberFormatException e) {
			return false;
		}
		
		return true;
	}

	public boolean saveCard(String type, String number, String name, String description, String exp_month, String exp_year, int userId) {
		if(description.trim().isEmpty()){
			description = "NULL";
		}
		else {
			description = "\""+description+"\"";
		}
		DAOCard daoCard = new DAOCard();
		
		return daoCard.saveCard(type, number, name, description, exp_month, exp_year, userId);
		
	}
	
	public boolean deleteCard(int userId, String cardId) {
		
		DAOCard daoCard = new DAOCard();
		
		return daoCard.deleteCard(userId, cardId);
	}
	
	/**
	 * Este metodo es una bandera para saber si el usuario tiene 
	 * cards activas
	 * @param id
	 * @return true, si hay al menos una card en status 1, false si son todas 0 o no existen.
	 */
	public boolean existActiveCardsForUser(int id) {
		ArrayList<Card> cardList = getCardsByUserID(id);
		if(cardList.isEmpty()) {
			return false;
		}
		for(Card c : cardList) {
			if(c.getStatus() == 1) {
				return true;
			}
		}
		
		return false;
	}
	
	/**
	 * Este metodo devuelve una card busando por su id
	 * @param id <de la Card>
	 * @return Card o Null
	 */
	public Card getCard(int id){
		Card card = null;
		
		DAOCard daoCard = new DAOCard();
		ResultSet rs = daoCard.getCard(id);
		
		String description, number, name, type;
		int cardId, status, exp_year, exp_month;
		
		try {
			while(rs.next()) {
				cardId = rs.getInt("cardId");
				number = rs.getString("number");
				status = rs.getInt("status");
				description = rs.getString("description");
				name = rs.getString("name");
				type = rs.getString("type");
				exp_year = rs.getInt("exp_year");
				exp_month = rs.getInt("exp_month");
				
				card = new Card(cardId, number, status, description, name, type, exp_year, exp_month);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		daoCard.done();
		return card;
	}
}
