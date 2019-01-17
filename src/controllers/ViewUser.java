package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Comment;
import business.Play;
import business.User;
import services.CommentHandler;
import services.PlayHandler;
import services.UserHandler;

/**
 * Servlet implementation class ViewUser
 */
@WebServlet("/viewuser")
public class ViewUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loggedUser = (User) request.getSession().getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		int requestedUserId = 0;
		
		try {
			requestedUserId = Integer.parseInt(request.getParameter("requestedUserId"));
		}
		catch (NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e= El usuario solicitado no existe");
			return;
		}
		
		User requestedUser;
		if(requestedUserId != loggedUser.getUserId()) {
			UserHandler userHandler = new UserHandler();
			requestedUser = userHandler.getUser(requestedUserId);
		}
		else {
			//Si soy yo mismo
			requestedUser = loggedUser;		
		}
		
		// Tengo que validar no dejar entrar a ver al usuario si sos cliente y el usuario esta inactivo
		if(requestedUser.getStatus() != 1 && loggedUser.isClient()) {
			response.sendRedirect("error.jsp?e= El usuario solicitado esta inactivo");
			return;
		}
			
		// Busco la biblioteca del usuario en cuestion
		UserHandler userHandler = new UserHandler();
		PlayHandler playHandler = new PlayHandler();
		ArrayList<String> playIdList = userHandler.playsInThisLibrary(requestedUser.getUserId());
		ArrayList<Play> playList = new ArrayList<Play>();
		if(!playIdList.isEmpty()) {
			playList = playHandler.getThesePlays(playIdList);
		}
		
		// Busco los comentarios en los que se vio implicado el usuario requested
		CommentHandler commentHandler = new CommentHandler();
		HashMap<Integer, Comment> comments = commentHandler.getCommentsForUser(requestedUserId);
		
		request.setAttribute("comments", comments);
		request.setAttribute("library", playList);
		request.setAttribute("requestedUser", requestedUser);
		request.getRequestDispatcher("viewuser.jsp").forward(request, response);
		
	}

}
