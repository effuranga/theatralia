package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.UserHandler;

/**
 * Servlet implementation class RemoveFromLibrary
 */
@WebServlet("/removefromlibrary")
public class RemoveFromLibrary extends HttpServlet {
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
		try {
			int userId = user.getUserId();
			int playId = Integer.parseInt(request.getParameter("playId"));
			UserHandler userHandler = new UserHandler();
			boolean success = userHandler.removeFromLibrary(userId, playId);
			if(success) {
				if(request.getParameter("returnToLibrary") == null && request.getParameter("returnToViewUser") == null) {
					//Vengo de viewPlay
					response.sendRedirect("viewplay?id="+playId);
				}
				if(request.getParameter("returnToLibrary") != null) {
					//Vengo de library
					response.sendRedirect("library");
				}		
				if(request.getParameter("returnToViewUser") != null) {
					//Vengo de viewUser
					response.sendRedirect("viewuser?requestedUserId="+user.getUserId());
				}		
			}
			else {
				response.sendRedirect("error.jsp?e=No se removio de la biblioteca correctamente");
			}
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Parametro incorrecto");
		}
	}
}
