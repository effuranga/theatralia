package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.Ticket;
import business.User;
import services.PurchaseHandler;
import services.TicketHandler;
import utils.DTOSell;

/**
 * Servlet implementation class ConfirmPurchase
 */
@WebServlet("/confirmsale")
public class ConfirmSale extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Ultimo paso de la compra, genera ticket, pega en las tablas, actualiza los datos.
	 * Recupero de la session el DTOSell como "sell"
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		DTOSell dto = (DTOSell) session.getAttribute("sell");
		
		if(user == null || dto == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (con permisos correspondientes) para poder realizar esta accion.");
			return;
		}
		
		// Checkear que el DTO sea apto para impactar la DB
		boolean isFit = dto.isFit();
		if(!isFit) {
			response.sendRedirect("error.jsp?e=ERROR 209: El DTOSell no es fit");
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
			response.sendRedirect("error.jsp?e=Fallo la venta. Puede haber quedado data inconsistente. Comuniquese con el 0-800");
		}

	}

}
