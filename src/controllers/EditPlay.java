package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Play;
import business.User;
import services.PlayHandler;

/**
 * Cuando es llamado con GET nos sirve la pagina de edicion segun el ID de la URL
 * Cuando es llamado con POST nos actualiza la informacion de la obra en cuestion en la DB
 */
@WebServlet("/editplay")
public class EditPlay extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Necesito ser admin y ademas me tiene que venir el ID de la play en el request
		User user = (User) request.getSession().getAttribute("loggedUser");
		String id = request.getParameter("playid");
		if(user == null || !user.isAdmin() || id == null || id.trim().isEmpty()) {
			response.sendRedirect("error.jsp?e=Fallo la validacion de parametros iniciales para poder editar la obra.");
			return;
		}
		try {
			int playId = Integer.parseInt(id);
			PlayHandler playHandler = new PlayHandler();
			Play play = playHandler.getWholePlay(playId);
			if(play == null) {
				response.sendRedirect("error.jsp?e=La obra buscada no existe");
				return;
			}
			request.setAttribute("play", play);
			request.getRequestDispatcher("editplay.jsp").forward(request, response);		
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Parseo de playId incorrecto");
			return;
		}
		

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


	}

}
