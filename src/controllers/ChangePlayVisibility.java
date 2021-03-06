package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.PlayHandler;

/**
 * Servlet implementation class ChangePlayVisibility
 */
@WebServlet("/changeplayvisibility")
public class ChangePlayVisibility extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como administrador) para poder realizar esta accion.");
			return;
		}
		try {
			int playId = Integer.parseInt(request.getParameter("playId"));
			int toStatus = Integer.parseInt(request.getParameter("toStatus"));
			
			PlayHandler playHandler = new PlayHandler();
			boolean valid = playHandler.changePlayStatus(playId, toStatus);
			
			if(valid) {
				response.sendRedirect("adminplays");
			}
			else {
				response.sendRedirect("error.jsp?e=Ocurrio un error durante la edicion de la obra. Intentelo de nuevo mas tarde");
			}
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Ocurrio un error al realizar esta accion. Intentelo de nuevo mas tarde");
		}
	}

}
