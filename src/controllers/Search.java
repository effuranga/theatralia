package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.Play;
import business.User;
import services.PlayHandler;

/**
 * Servlet implementation class Search
 */
@WebServlet("/search")
public class Search extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		if(request.getParameter("q") == null) {
			response.sendRedirect("home");
			return;
		}
		
		if(request.getParameter("q").trim().isEmpty()) {
			response.sendRedirect("search.jsp?action=nowords");
			return;
		}
		
		String[] words = request.getParameter("q").split("\\W+");
		PlayHandler playHandler = new PlayHandler();
		ArrayList<Play> playsResult = playHandler.getPlaysBySearch(words);
		
		for(Play p : playsResult) {
			System.out.println(p.getId());
		}
		
		request.setAttribute("playsResult", playsResult);
		request.getRequestDispatcher("searchresult.jsp").forward(request, response);
	}

}
