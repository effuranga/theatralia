package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet implementation class Home
 */
@WebServlet(
		description = "This servlets handles the landing page of the application", 
		urlPatterns = { 
				"/home", 
				"/index",
				"/initializer"
		})
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RequestDispatcher requestDispatcher;
		//valido si el usuario está logeado y lo redirijo a su dashboard
		if(session.getAttribute("loggedUser") != null) {			
			requestDispatcher = request.getRequestDispatcher("dashboard");
			requestDispatcher.forward(request, response);
		}
		else {
			/*
			PlayHandler playHandler = new PlayHandler();
			ArrayList<Play> starredPlays = playHandler.getStarredPlays();		
			request.setAttribute("starredPlays", starredPlays);
			*/
			String action = "";
			if(request.getParameter("falseauth") != null && request.getParameter("falseauth").equals("true")) {
				action = "?action=falseauthentication";
			}
			if(request.getParameter("inactive") != null && request.getParameter("inactive").equals("true")) {
				action = "?action=inactive";
			}
			requestDispatcher = request.getRequestDispatcher("home.jsp"+action);
			requestDispatcher.forward(request, response);
		}
		
		
	}
/*
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	
	}
*/	
}
