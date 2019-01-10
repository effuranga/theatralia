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
 * Servlet implementation class Delivery
 */
@WebServlet("/delivery")
public class Delivery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Para la entrega de tickets (y opcionalmente cobrar) SOLO PARA TICKETS DE HOY EN ADELANTE
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || loggedUser.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como empleado o administrador) para poder realizar esta accion.");
			return;
		}
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTODeliveryTable> deliveryTableDTOs = new ArrayList<DTODeliveryTable>();
		
		deliveryTableDTOs = ticketHandler.getDeliveryTableDTOs();
		
		request.setAttribute("rows", deliveryTableDTOs);
		request.getRequestDispatcher("delivery.jsp").forward(request, response);
	}

}
