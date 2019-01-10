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
 * Servlet implementation class AddToLibrary
 */
@WebServlet("/addtolibrary")
public class AddToLibrary extends HttpServlet {
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
			boolean success = userHandler.addToLibrary(userId, playId);
			if(success) {
				response.sendRedirect("viewplay?id="+playId);
			}
			else {
				response.sendRedirect("error.jsp?e=Ocurrio un error al agregar esta obra a tu biblioteca.");
			}
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=La obra solicitada no existe.");
		}
	}

}
