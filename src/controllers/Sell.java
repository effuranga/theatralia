package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Play;
import business.Show;
import business.User;
import services.PlayHandler;
import utils.DTOSell;

/**
 * Servlet implementation class SellFields
 */
@WebServlet("/sell")
public class Sell extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/**
	 * VENTA; Recibo del request "id" que es el id de la Play - puede ser que no lo necesite, y "showId".
	 * Hay que redireccionar a elegir los asientos.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Vaildaer que el usuario este loggeado y NO sea cliente
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || user.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como cliente o administrador) para poder realizar esta accion.");
			return;
		}
		
		int showId = 0;
		int playId = 0;
	// Validar que los parametros sean correctos
		try {
			showId = Integer.parseInt(request.getParameter("showId"));
			playId = Integer.parseInt(request.getParameter("id"));
		}
		catch(NumberFormatException e) {
			response.sendRedirect("error.jsp?e=Los parametros no son validos");
			return;
		}
			
	//  Busco la obra para ubicar su show
		PlayHandler playHandler = new PlayHandler();
		Play play = playHandler.getWholePlay(playId);
		ArrayList<Show> shows = play.getShows();
		Show show = null;
		for(Show s : shows) {
			if(s.getId() == showId) {
				show = s;
				break;
			}
		}
		if(show == null) {
			response.sendRedirect("error.jsp?e=No hay un show con ese id");
			return;
		}
	
	// Armo el DTO y lo pongo en la sessino con el nombre PURCHASE - igual que la compra - para poder reutilizar seatsselector.jsp
		DTOSell dto = new DTOSell(play, user, show);
		request.getSession().setAttribute("sell", dto);
		
		request.setAttribute("show", show);
		request.getRequestDispatcher("seatsselector.jsp").forward(request, response); 	
	}

}
