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

import business.Comment;
import business.Play;
import business.User;
import services.CommentHandler;
import services.PlayHandler;
import services.UserHandler;

/**
 * Toma el pedido para ver una obra por metodo GET (?id=<id>)
 * La recupera y redirige al jsp asociado a este servlet (viewplay.jsp)
 * pasandole la Play como atributo en el request
 * @author Eff
 *
 */
@WebServlet("/viewplay")
public class ViewPlay extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado");
			return;
		}
		
		String id = request.getParameter("id");
		if(id != null && !id.trim().isEmpty()) {
			PlayHandler playHandler = new PlayHandler();
		//	Play play = playHandler.getBasicPlay(id);
			Play play = playHandler.getWholePlay(Integer.parseInt(id));
			if(play == null) {
				response.sendRedirect("error.jsp?e=La obra solicitada no existe");
			}
			else {
				playHandler.fillWithShows(play); 
				play.removeShowsWithNoSeatsLeft();
				play.removeShowsFromThePast();
				request.setAttribute("play", play);	
				
				// Necesito saber si la obra está guardada en la biblioteca del usuario
				UserHandler userHandler = new UserHandler();
				boolean addedInLibrary = userHandler.isThisPlayInLibrary(loggedUser.getUserId(), play.getId());
				request.setAttribute("addedInLibrary", addedInLibrary);
				
				// Necesito recuperar los comentarios de la obra
				CommentHandler commentHandler = new CommentHandler();
				HashMap<Integer, Comment> comments = commentHandler.getCommentsForPlay(play.getId());
							
				// Necesito llenar de likes los comentarios
				commentHandler.fillWithLikes(comments);
				
				request.setAttribute("comments", comments);
				
				RequestDispatcher requestDispatcher = request.getRequestDispatcher("viewplay.jsp");
				requestDispatcher.forward(request, response);
			}
		}

	}

}
