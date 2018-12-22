package services;

import daos.DAOSeat;
import daos.DAOTicket;
import utils.DTOPurchase;
import utils.DTOSell;

public class PurchaseHandler {
	
	/**
	 * Efectiviza la COMPRA llamando a los DAOs que impactan en Ticket, TicketShowSeat, y ShowSeat
	 * @param DTOPurchase
	 * @return ticketID recien creado, sino 0
	 */
	public int commitPurchase(DTOPurchase dto) {
		DAOTicket daoTicket = new DAOTicket();
		DAOSeat daoSeat = new DAOSeat();
		
		int ticketId = daoTicket.createTicket(dto);
		boolean resultSeat = daoSeat.occupySeats(dto.getSeats());
		
		if(ticketId !=0 && resultSeat) {
			return ticketId;
		}
		
		return 0;
	}
	
	
	/**
	 * Efectiviza la VENTA llamando a los DAOs que impactan en Ticket, TicketShowSeat, y ShowSeat
	 * @param DTOSell
	 * @return ticketID recien creado, sino 0
	 */
	public int commitPurchase(DTOSell dto) {
		DAOTicket daoTicket = new DAOTicket();
		DAOSeat daoSeat = new DAOSeat();
		
		int ticketId = daoTicket.createTicket(dto);
		boolean resultSeat = daoSeat.occupySeats(dto.getSeats());
		
		if(ticketId != 0 && resultSeat) {
			return ticketId;
		}
		
		return 0;
	}

}
