package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.TicketHandler;
import utils.DTOTicketList;

/**
 * Servlet implementation class ListTickets
 */
@WebServlet("/listtickets")
public class ListTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como administrador) para poder realizar esta accion.");
			return;
		}
		int showId = 0;
		
		try {
			showId = Integer.parseInt(request.getParameter("showId"));
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=El parametro es invalido");
			return;
		}
		
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTOTicketList> ticketsListDTOs = new ArrayList<DTOTicketList>();
		
		ticketsListDTOs = ticketHandler.getTicketsListDTOs(showId);
		
		request.setAttribute("ticketslist", ticketsListDTOs);
		request.getRequestDispatcher("ticketslist.jsp").forward(request, response);
	}
}
