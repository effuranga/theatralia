package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.CardHandler;

/**
 * Servlet implementation class DeleteCard
 */
@WebServlet("/deletecard")
public class DeleteCard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		String cardId = request.getParameter("id");
		
		if(user == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		CardHandler cardHandler = new CardHandler();
		
		boolean result = cardHandler.deleteCard(user.getUserId(), cardId);
		
		if(result) {
			response.sendRedirect("mycards?message=La tarjeta se ha eliminado correctamente");
		}
		else {
			response.sendRedirect("error.jsp?e=No tiene permiso para eliminar esta tarjeta");
		}
	}

}
