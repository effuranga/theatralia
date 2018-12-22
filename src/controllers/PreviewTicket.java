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
import services.TicketHandler;

/**
 * Servlet implementation class PreviewTicket
 */
@WebServlet("/previewticket")
public class PreviewTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || loggedUser.isClient()) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado o soy cliente");
			return;
		}
		int ticketId = Integer.parseInt(request.getParameter("ticketId"));
		TicketHandler ticketHandler = new TicketHandler();
		Ticket ticket = ticketHandler.retrieveTicket(ticketId);
		
		if(ticket != null) {
			request.setAttribute("ticket", ticket);
			request.getRequestDispatcher("previewticket.jsp").forward(request, response);
		}
		else {
			response.sendRedirect("error.jsp?e=No hay ticket con ese id");
			return;
		}
		
	}

}
