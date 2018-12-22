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
import utils.DTODeliveryTable;

/**
 * Servlet implementation class ExpiredTickets
 */
@WebServlet("/expiredtickets")
public class ExpiredTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Muestra los tickets con fecha de ayer o posterior, NO ENTREGADOS
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//TODO llamar a los tickets pasados y ofrecer cargar en la tarjeta a aquellos que no esten pagos, permitir filtrar
		//TODO por los que no estan pagos y permitir cargar de a uno o en bulk
		
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado o no soy admin");
			return;
		}
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTODeliveryTable> expiredTableDTOs = new ArrayList<DTODeliveryTable>();
		
		expiredTableDTOs = ticketHandler.getExpiredTableDTOs();
		
		request.setAttribute("rows", expiredTableDTOs);
		request.getRequestDispatcher("expiredtickets.jsp").forward(request, response);
	}

}
