package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Play;
import business.Show;
import business.User;
import services.PlayHandler;

/**
 * Servlet implementation class ViewChart
 */
@WebServlet("/viewchart")
public class ViewChart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Vaildar que el usuario este loggeado y sea cliente
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Admin) para poder realizar esta accion.");
			return;
		}
	
		int showId = 0;

		try {
			showId = Integer.parseInt(request.getParameter("showId"));			
		}
		catch(NumberFormatException e) {
			response.sendRedirect("error.jsp?e=Los parametros no son validos");
			return;
		}
		
		
		// Recupero la obra a partir del showId
		PlayHandler playHandler = new PlayHandler();
		Play play = playHandler.getPlayByShow(showId);
		if(play == null) {
			response.sendRedirect("error.jsp?e=No existe la obra para ese show");
			return;
		}
		// Recupero el show
		ArrayList<Show> shows = play.getShows();
		for(Show show : shows) {
			if(show.getId() == showId) {
				request.setAttribute("show", show);
				break;
			}
		}
		
		request.getRequestDispatcher("viewchart.jsp").forward(request, response); 
				
	}

}
