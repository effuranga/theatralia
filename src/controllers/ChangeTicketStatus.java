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
@WebServlet("/changeticketstatus")
public class ChangeTicketStatus extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || loggedUser.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como empleado o administrador) para poder realizar esta accion.");
			return;
		}
		
		int ticketId = Integer.parseInt(request.getParameter("ticketId"));
		
		TicketHandler ticketHandler = new TicketHandler();
		boolean valid = ticketHandler.changeTicketStatus(ticketId, loggedUser.getUserId());
		
		if(valid) {
			response.sendRedirect("validation.jsp?action=3");
		}
		else {
			response.sendRedirect("error.jsp?e=El cobro no se realizo de manera exitosa. Vuelva a intentarlo mas tarde.");
		}
	}

}
