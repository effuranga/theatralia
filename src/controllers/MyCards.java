package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.Card;
import business.User;
import services.CardHandler;

/**
 * Servlet implementation class MyCards
 */
@WebServlet("/mycards")
public class MyCards extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		
		if(user == null) {
			response.sendRedirect("error.jsp?e=El usuario no está en la sesión");
			return;
		}
		
		CardHandler cardHandler = new CardHandler();
		ArrayList<Card> cards = cardHandler.getCardsByUserID(user.getUserId());
		
		request.setAttribute("cards", cards);
		
		RequestDispatcher requestDispatcher;
		
		//Vengo desde MyProfile
		if(request.getParameter("message") == null) {
			requestDispatcher = request.getRequestDispatcher("mycards.jsp");
		}
		//Vengo desde bankvalidation
		else {
			requestDispatcher = request.getRequestDispatcher("mycards.jsp?message="+request.getParameter("message"));
		}	
		//Solicitud de nueva
		if(request.getParameter("add") != null && request.getParameter("add").equals("true")) {
			requestDispatcher = request.getRequestDispatcher("mycards.jsp?add=true");
		}
		
		requestDispatcher.forward(request, response);
	}

}
