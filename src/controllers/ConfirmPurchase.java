package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.Card;
import business.Ticket;
import business.User;
import services.CardHandler;
import services.PurchaseHandler;
import services.TicketHandler;
import utils.DTOPurchase;

/**
 * Servlet implementation class ConfirmPurchase
 */
@WebServlet("/confirmpurchase")
public class ConfirmPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Ultimo paso de la compra, genera ticket, pega en las tablas, actualiza los datos
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		DTOPurchase dto = (DTOPurchase) session.getAttribute("purchase");
		
		if(user == null || dto == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
// Recuperar la tarjeta
CardHandler cardHandler = new CardHandler();
Card card = cardHandler.getCard(Integer.parseInt(request.getParameter("card")));
dto.setCard(card);
		
		// Checkear que el DTO sea apto para impactar la DB
		boolean isFit = dto.isFit();
		if(!isFit) {
			response.sendRedirect("error.jsp?e=ERROR 209: El DTOPurchase no es fit");
			return;
		}
		
		PurchaseHandler purchaseHandler = new PurchaseHandler();
		int ticketId = purchaseHandler.commitPurchase(dto);
		
		if(ticketId != 0) {
			//Voy a mostrar el ticket por pantalla
			TicketHandler ticketHandler = new TicketHandler();
			Ticket ticket = ticketHandler.generateTicket(dto, ticketId);
			request.getSession().setAttribute("ticket", ticket);
			response.sendRedirect("viewticket.jsp");
		}
		else {
			response.sendRedirect("error.jsp?e=La venta ha fallado. Reintente nuevamente mas tarde");
		}

	}

}
