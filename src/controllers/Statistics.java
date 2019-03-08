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
import services.ShowHandler;
import utils.DTOStatistics;

/**
 * Servlet implementation class Statistics
 */
@WebServlet({ "/Statistics", "/stats" })
public class Statistics extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Administrador) para poder realizar esta accion.");
			return;
		}
		int playId = 0;
		
		try {
			playId = Integer.parseInt(request.getParameter("playId"));
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=El parametro es invalido");
			return;
		}
		
		// Busco la obra
		PlayHandler playHandler = new PlayHandler();
		Play play = playHandler.getBasicPlay(request.getParameter("playId"));
		if(play == null) {
			response.sendRedirect("error.jsp?e=No existe la obra especificada");
			return;
		}
		
		// Busco las estadisticas
		ShowHandler showHandler = new ShowHandler();
		ArrayList<DTOStatistics> stats = showHandler.getStatistics(playId);
		
		request.setAttribute("play", play);
		request.setAttribute("stats", stats);	
		request.getRequestDispatcher("statistics.jsp").forward(request, response);

	}

}
