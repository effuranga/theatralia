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
 * Servlet implementation class DislikeComment
 */
@WebServlet("/dislike")
public class DislikeComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		
		if(user == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		//Recupero el id del comment
		int commentId = 0;
		int playId = 0;
		try{
			commentId = Integer.parseInt(request.getParameter("commentId"));
			playId = Integer.parseInt(request.getParameter("playId"));
			if(commentId == 0 || playId == 0) throw new NumberFormatException();
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Parametro incorrecto");
			return;
		}
		
		CommentHandler commentHandler = new CommentHandler();
		boolean success = commentHandler.dislikeComment(user.getUserId(), commentId);
		
		if(success) {
			response.sendRedirect("viewplay?id="+playId+"#bar");
		}
		else {
			response.sendRedirect("error.jsp?e=Fallo el registro del like");
		}
	}

}
