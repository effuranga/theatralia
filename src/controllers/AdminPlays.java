package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Play;
import business.User;
import services.PlayHandler;

/**
 * Servlet implementation class AdminPlays
 */
@WebServlet("/adminplays")
public class AdminPlays extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?message= No estas loggeado o no sos admin");
			return;
		}
		PlayHandler playHandler = new PlayHandler();
		ArrayList<Play> allPlays = playHandler.getAllPlays();
		
		request.setAttribute("allPlays", allPlays);
		request.getRequestDispatcher("allplays.jsp").forward(request, response);
	}

}
