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
 * Servlet implementation class ChargeAllCards
 */
@WebServlet("/chargeallcards")
public class ChargeAllCards extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Administrador) para poder realizar esta accion.");
			return;
		}
		
		
		
		TicketHandler ticketHandler = new TicketHandler();
		boolean valid = ticketHandler.chargeAllCards();
		
		if(valid) {
			response.sendRedirect("validation.jsp?action=6");
		}
		else {
			response.sendRedirect("error.jsp?e=La carga en bloque ha fallado. Vuelva a intentarlo mas tarde.");
		}
	}

}
