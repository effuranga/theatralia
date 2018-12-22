package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.TicketHandler;

/**
 * Servlet implementation class PayTicket
 */
@WebServlet("/payticket")
public class ChargeInCard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado o no soy Admin");
			return;
		}
		
		int ticketId = Integer.parseInt(request.getParameter("ticketId"));
		
		TicketHandler ticketHandler = new TicketHandler();
		boolean valid = ticketHandler.payTicketByChargingInCard(ticketId, loggedUser.getUserId());
		
		if(valid) {
			response.sendRedirect("validation.jsp?action=5");
		}
		else {
			response.sendRedirect("error.jsp?e=Problema con el cobro");
		}
	}

}
