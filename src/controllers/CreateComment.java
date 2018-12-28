package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.CommentHandler;

/**
 * Servlet implementation class CreateComment
 */
@WebServlet("/createcomment")
public class CreateComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado");
			return;
		}
		
		//Recupero datos del comentario
		String parentIdString = (String) request.getParameter("parentId");
		boolean isParent = (parentIdString == null || parentIdString.trim().isEmpty())? true : false;
		String text = (String) request.getParameter("text");
		int userId = loggedUser.getUserId();
		int playId = 0;
		int parentId = 0;
		try {
			playId = Integer.parseInt((String) request.getParameter("playId"));
			if(!isParent) {
				parentId = Integer.parseInt((String) request.getParameter("parentId"));
			}
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Error de parametros");
			return;
		}
		
		// Bifurco si es padre o hijo, lo creo y retorno
		CommentHandler commentHandler = new CommentHandler();
		int newCommentId = (isParent)? commentHandler.createParent(userId, playId, text) : commentHandler.createChild(parentId, userId, playId, text);
		
		if(newCommentId != 0) {
			response.sendRedirect("viewplay?id="+playId+"&action=newcommentsuccess#bar");
		}
		else {
			response.sendRedirect("error.jsp?e=Error en la creación del comment");
		}
	}

}
