package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Ticket;
import business.User;

/**
 * Servlet implementation class ViewTicket
 */
@WebServlet("/viewticket")
public class ViewTicket extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * No sé si necesito esta clase
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		User user = (User) request.getSession().getAttribute("loggedUser");
//		Ticket ticket = (Ticket) request.getAttribute("ticket");
//		if(user == null || ticket == null) {
//			response.sendRedirect("error.jsp?e=El usuario no está loggeado o no hay ticket");
//			return;
//		}
//		if(user.isClient()) {
//			
//		}
	}

}
