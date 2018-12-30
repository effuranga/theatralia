package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class NewComment
 */
@WebServlet("/newcomment")
public class NewComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		
		if(user == null) {
			response.sendRedirect("error.jsp?e=El usuario no esta loggeado");
			return;
		}
		
		// Inicialización de variables
		int userId = user.getUserId();
		int playId = 0;
		int parentId = 0;
		boolean isParent = false;
		String text = request.getParameter("text");
		try {
			playId = Integer.parseInt(request.getParameter("playId"));
		}
		catch(NumberFormatException e) {
			response.sendRedirect("error.jsp?e=Error al parsear el playId");
			return;
		}
		if(playId == 0) {
			response.sendRedirect("error.jsp?e=La obra no es valida");
			return;
		}
		
		try {
			parentId = Integer.parseInt(request.getParameter("parentId"));
			// Si no falla es un comentario hijo
		}
		catch(NumberFormatException e) {
			// Falla, es un comentario padre
			isParent = true;
		}
		
		CommentHandler commentHandler = new CommentHandler();
		boolean success = false;
		if(isParent) {
			success = commentHandler.createParent(userId, playId, text);
		}
		else {
			success = commentHandler.createChild(parentId, userId, playId, text);
		}
		
		if(success) {
			response.sendRedirect("success.jsp");
		}
		else {
			response.sendRedirect("error.jsp?e=Ha ocurrido un error durante la creación del comentario");
		}
		
		*/
	}

}
