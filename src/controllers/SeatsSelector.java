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
import business.Card;
import services.CardHandler;
import utils.DTOPurchase;

/**
 * Servlet implementation class SeatsSelector
 */
@WebServlet("/seatsselector")
public class SeatsSelector extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Recibe showId, cantSeats, delivery (1: pagar con tarjeta, 2: pagar por ventanilla)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	// Vaildar que el usuario este loggeado y sea cliente
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isClient()) {
			response.sendRedirect("error.jsp?e=El usuario no esta loggeado o no es un cliente");
			return;
		}
	
		int showId = 0;
		int cantSeats = 0;
		int delivery = 0;
		int cardId = 0;
		boolean payWithCard = false;
	// Validar que los parametros sean correctos
		try {
			showId = Integer.parseInt(request.getParameter("showId"));
			cantSeats = Integer.parseInt(request.getParameter("cantSeats"));
			delivery = Integer.parseInt(request.getParameter("delivery"));
			cardId = Integer.parseInt(request.getParameter("card"));
			
			payWithCard = (delivery == 1)? true : false;
		}
		catch(NumberFormatException e) {
			response.sendRedirect("error.jsp?e=Los parametros no son validos");
			return;
		}
		
	// Recupero la card
		CardHandler cardHandler = new CardHandler();
		Card card = cardHandler.getCard(cardId);
			
	// Recupero la obra de la session y ubico su show
		DTOPurchase dto = (DTOPurchase) request.getSession().getAttribute("purchase");
		Play play = dto.getPlay();
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
	
	// Termino de armar el DTO	
		dto.setShow(show);
		dto.setPayWithCard(payWithCard);
		dto.setCantSeats(cantSeats);
		dto.setCard(card);
		request.getSession().setAttribute("purchase", dto);
		
		request.setAttribute("show", show);
		request.getRequestDispatcher("seatsselector.jsp").forward(request, response); 
		//No voy a abrir el DTO en seatsselector, porque sino tengo que distinguir entre el DTO de la Sell y el del Purchase		
	}

}
