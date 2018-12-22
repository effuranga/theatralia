package controllers;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
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
 * Servlet implementation class Dashboard
 */
@WebServlet("/dashboard")
public class Dashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Para acceder a este servlet, el usuario tiene que estar loggeado. Valido
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado");
			return;
		}
		/*Al estar loggeado, necesito popular las obras actuales en el dashboard asi que las pido
		se las pongo al request, y dispatcheo
		*/
		PlayHandler playHandler = new PlayHandler();
		HashMap<Integer, Play> currentPlays = playHandler.getCurrentPlays();
		request.setAttribute("currentPlays", currentPlays);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("dashboard.jsp");
		requestDispatcher.forward(request, response);

	}

}
