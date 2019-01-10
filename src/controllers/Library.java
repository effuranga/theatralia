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
import services.UserHandler;

/**
 * Servlet implementation class Library
 */
@WebServlet("/library")
public class Library extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como cliente) para poder realizar esta accion.");
			return;
		}
		UserHandler userHandler = new UserHandler();
		PlayHandler playHandler = new PlayHandler();
		ArrayList<String> playIdList = userHandler.playsInThisLibrary(user.getUserId());
		ArrayList<Play> playList = new ArrayList<Play>();
		if(!playIdList.isEmpty()) {
			playList = playHandler.getThesePlays(playIdList);
		}
		
		request.setAttribute("playList", playList);
		request.getRequestDispatcher("library.jsp").forward(request, response);
	}

}
