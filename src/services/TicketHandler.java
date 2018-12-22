package services;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import business.Card;
import business.Play;
import business.Seat;
import business.Show;
import business.Ticket;
import business.User;
import daos.DAOTicket;
import utils.DTODeliveryTable;
import utils.DTOPurchase;
import utils.DTOSell;

public class TicketHandler {

	/**
	 * Generar el ticket de COMPRA
	 * @param DTOPurchase
	 * @param ticketId
	 * @return
	 */
	public Ticket generateTicket(DTOPurchase dto, int ticketId) {	
		int id = ticketId;
		Play play = dto.getPlay();
		Show show = dto.getShow();
		boolean isPaid = dto.isPayWithCard();
		boolean isDelivered = false; //Es una compra
		Card card = dto.getCard();
		ArrayList<Seat> seats = dto.getSeats();
		User user = dto.getUser(); //El cliente
		
		return new Ticket(id, play, show, isPaid, isDelivered, card, seats, user);	
	}
	
	/**
	 * Generar el ticket de VENTA
	 * @param DTOSell
	 * @param ticketId
	 * @return
	 */
	public Ticket generateTicket(DTOSell dto, int ticketId) {
		int id = ticketId;
		Play play = dto.getPlay();
		Show show = dto.getShow();
		boolean isPaid = true;
		boolean isDelivered = true; //Es una venta
		Card card = null;
		ArrayList<Seat> seats = dto.getSeats();
		User user = dto.getUser(); //El vendedor
		
		return new Ticket(id, play, show, isPaid, isDelivered, card, seats, user);	
	}
	
	/**
	 * Devuelve el buying date de un determinado Ticket. Se usa en el constructor del ticket
	 * @param ticketId
	 * @return String buyingDate o NULL si el ticket no existe, porque buyingDate IS NOT NULL
	 */
	public String getBuyingDate(int ticketId) {
		DAOTicket daoTicket = new DAOTicket();
		
		return daoTicket.getBuyingDate(ticketId);
	}
	
	/**
	 * Devuelve el delivery code de un determinado Ticket. Se usa en el constructor del ticket
	 * @param ticketId
	 * @return String deliverCode o NULL
	 */
	public String getDeliveryCode(int ticketId) {
		DAOTicket daoTicket = new DAOTicket();
		
		return daoTicket.getDeliveryCode(ticketId);
	}

	/**
	 * Devuelve todos los tickets con status en 0: not delivered
	 * @return tickets LLENO o VACIO
	 */
	/*
	public ArrayList<Ticket> getTicketsForDelivery() {
		ArrayList<Ticket> tickets = new ArrayList<Ticket>();
		DAOTicket daoTicket = new DAOTicket();
		
		ResultSet rs = daoTicket.getTicketsIdsForDelivery();
		try {
			ArrayList<String> ids = new ArrayList<String>();
			while(rs.next()) {
				ids.add(rs.getString(1));
			}
			daoTicket.done();
			
			for(String s : ids) {
				tickets.add(retrieveTicket(Integer.parseInt(s)));
			}
		} catch (SQLException e) {
			e.printStackTrace();
			daoTicket.done();
		}
		return tickets;
	}
	*/
	
	/**
	 * Devuelve un ticket COMPLETO segun su id
	 * @param ticketId
	 * @return
	 */
	public Ticket retrieveTicket(int ticketId) {
		DAOTicket daoTicket = new DAOTicket();
		ResultSet rs = daoTicket.getRow(ticketId);
		
		try {
			if(rs.next()) {
				int playId = rs.getInt("playId");
				int showId = rs.getInt("showId");
				boolean isPaid = (rs.getInt("isPaid") == 0)?  false : true;
				boolean isDelivered = false;
				int cardId = rs.getInt("cardId");
				ArrayList<Seat> seats = new ArrayList<Seat>();
				int userId = rs.getInt("userId");
				String buyingDate = rs.getString("buyingDate");
				String deliveryCode = rs.getString("deliveryCode");
				
				Ticket ticket = new Ticket(ticketId, null, null, isPaid, isDelivered, null, seats, null, buyingDate, deliveryCode);
				daoTicket.done();
				
				//Termino de definirle la play al Ticket
				PlayHandler playHandler = new PlayHandler();
				Play play = playHandler.getWholePlay(playId);
				ticket.setPlay(play);
				
				//Obtengo el show de la play y se lo agrego al Ticket
				ShowHandler showHandler = new ShowHandler();
				ticket.setShow(showHandler.locateShow(play, showId));
				
				//Tengo que ponerle su card
				CardHandler cardHandler = new CardHandler();
				ticket.setCard(cardHandler.getCard(cardId));
				
				//Los asientos man
				ticket.getSeats().addAll(getSeatsForThisTicket(ticketId));
				
				//El user
				UserHandler userHandler = new UserHandler();
				ticket.setUser(userHandler.getUser(userId));
				
				return ticket;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	/**
	 * Devuelve un arreglo de Seats pertenecientes al ticket
	 * @param ticketId
	 * @return seats LLENO o VACIO
	 */
	public ArrayList<Seat> getSeatsForThisTicket(int ticketId) {
		ArrayList<Seat> seats = new ArrayList<Seat>();
		ArrayList<String> seatsIds = new ArrayList<String>();
		DAOTicket daoTicket = new DAOTicket();
		SeatHandler seatHandler = new SeatHandler();
		
		seatsIds = daoTicket.getSeatsIds(ticketId);
		
		for(String id : seatsIds) {
			seats.add(seatHandler.getSeat(id));
		}
		return seats;
	}

	/**
	 * Devuelve un arreglo lleno de DTODeliverTable donde cada uno de estos es una fila de la tabla delivery.jsp
	 * @return deliveryRows LLENO o VACIO
	 */
	public ArrayList<DTODeliveryTable> getDeliveryTableDTOs() {
		ArrayList<DTODeliveryTable> deliveryRows = new ArrayList<DTODeliveryTable>();
		DAOTicket daoTicket = new DAOTicket();
		ResultSet rs = daoTicket.getDeliveryTableRows();
		
		try {
			while(rs.next()) {
				int ticketId = rs.getInt("ticketId");
				int playId = rs.getInt("playId");
				int cardId = rs.getInt("cardId");
				int clientId = rs.getInt("userId");
				int showId = rs.getInt("showId");
				String playName = rs.getString("playName");
				String showDate = rs.getString("showDate");
				String userName = rs.getString("userName");
				String userLastName= rs.getString("userLastName");
				String cardNumber= rs.getString("cardNumber");
				boolean isPaid = (rs.getInt("isPaid") == 0)? false : true; 
				String deliveryCode = rs.getString("deliveryCode");
				String buyingDate= rs.getString("buyingDate");
				
				deliveryRows.add(new DTODeliveryTable(ticketId, playId, cardId, clientId, showId, playName, showDate, userName, userLastName, cardNumber, isPaid, deliveryCode, buyingDate));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		daoTicket.done();
		return deliveryRows;
	}

	/**
	 * Cambia el isPaid del ticket a 1 y crea un registro en la tabla deskCash para trackear el cobro
	 * @param ticketId
	 * @return
	 */
	public boolean payTicketInDesk(int ticketId, int userId) {
		DAOTicket daoTicket = new DAOTicket();
		
		return daoTicket.payTicketInDesk(ticketId, userId);
		
	}
	
	/**
	 * Cambia el status del ticket a 1 y crea un registro en la tabla delivery para trackear la entrega
	 * @param ticketId
	 * @return
	 */
	public boolean changeTicketStatus(int ticketId, int userId) {
		DAOTicket daoTicket = new DAOTicket();
		
		return daoTicket.changeTicketStatus(ticketId, userId);
		
	}
	
	/**
	 * Devuelve un arreglo lleno de DTODeliverTable donde cada uno de estos es una fila de la tabla expiredtickets.jsp
	 * @return expiredRows LLENO o VACIO
	 */
	public ArrayList<DTODeliveryTable> getExpiredTableDTOs() {
		ArrayList<DTODeliveryTable> expiredRows = new ArrayList<DTODeliveryTable>();
		DAOTicket daoTicket = new DAOTicket();
		ResultSet rs = daoTicket.getExpiredTableRows();
		
		try {
			while(rs.next()) {
				int ticketId = rs.getInt("ticketId");
				int playId = rs.getInt("playId");
				int cardId = rs.getInt("cardId");
				int clientId = rs.getInt("userId");
				int showId = rs.getInt("showId");
				String playName = rs.getString("playName");
				String showDate = rs.getString("showDate");
				String userName = rs.getString("userName");
				String userLastName= rs.getString("userLastName");
				String cardNumber= rs.getString("cardNumber");
				boolean isPaid = (rs.getInt("isPaid") == 0)? false : true; 
				String deliveryCode = rs.getString("deliveryCode");
				String buyingDate= rs.getString("buyingDate");
				
				expiredRows.add(new DTODeliveryTable(ticketId, playId, cardId, clientId, showId, playName, showDate, userName, userLastName, cardNumber, isPaid, deliveryCode, buyingDate));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		daoTicket.done();
		return expiredRows;
	}

	/**
	 * Este metodo cambia el isPaid del ticket a 1 (paid) y agrega un record en la tabla chargedCard
	 * @param ticketId
	 * @param userId
	 * @return
	 */
	public boolean payTicketByChargingInCard(int ticketId, int userId) {
		DAOTicket daoTicket = new DAOTicket();
		
		return daoTicket.payTicketByChargingInCard(ticketId, userId);
	}
}
