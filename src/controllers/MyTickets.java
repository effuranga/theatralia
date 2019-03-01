package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.TicketHandler;
import utils.DTOMyTickets;

/**
 * Servlet implementation class MyTickets
 */
@WebServlet("/mytickets")
public class MyTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Cliente) para poder realizar esta accion.");
			return;
		}
		
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTOMyTickets> dtoMyTicketsList = ticketHandler.getDTOMyTicketsList(user.getUserId());
		
		request.setAttribute("dto", dtoMyTicketsList);
		request.getRequestDispatcher("mytickets.jsp").forward(request, response);
		
	}

}
