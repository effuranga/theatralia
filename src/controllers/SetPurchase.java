package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.Card;
import business.Play;
import business.User;
import services.CardHandler;
import services.PlayHandler;
import utils.DTOPurchase;

/**
 * Servlet implementation class SetPurchase
 */
@WebServlet("/setpurchase")
public class SetPurchase extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Recibo como parte de la URL el id de la play. Es para buscar la data para la primera
	 * configuración de la compra a la obra
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Vaildaer que el usuario este loggeado y sea cliente
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como cliente) para poder realizar esta accion.");
			return;
		}
		
		// Validar que el id me devuelve una obra valida
		String idS = request.getParameter("id");
		int id = 0;
		try {
			id = Integer.parseInt(idS);
		}
		catch(NumberFormatException e) {
			response.sendRedirect("error.jsp?e=El id de la obra no es valido");
			return;
		}
		PlayHandler playHandler = new PlayHandler();
		Play play = playHandler.getWholePlay(id);
		if(play == null) {
			response.sendRedirect("error.jsp?e=La obra solicitada no existe");
			return;
		}
		
		// Validar que la obra tenga shows
		if(play.getShows().isEmpty()) {
			response.sendRedirect("error.jsp?e=No existen funciones");
			return;
		}
		
		// Quitar de la obra los shows con estado 0 (los shows sin asientos libres)
		play.removeShowsWithNoSeatsLeft();
		
		// Quitar de la obra los shows pasados
		play.removeShowsFromThePast();
		
		// Validar que el usuario tenga tarjetas activas
		CardHandler cardHandler = new CardHandler();
		boolean activeCards = cardHandler.existActiveCardsForUser(user.getUserId());
		if(!activeCards) {
			response.sendRedirect("error.jsp?e=El usuario no tiene tarjetas activas.");
			return;
		}
		
		// Recuperar las tarjetas (TODAS) del usuario
		ArrayList<Card> allCards = cardHandler.getCardsByUserID(user.getUserId());
		
		// El usuario es cliente y tiene tarjeta, la obra existe y tiene shows
		DTOPurchase dtoPurchase = new DTOPurchase(play, user);
		request.getSession().setAttribute("purchase", dtoPurchase);
		
		request.setAttribute("play", play);
		request.setAttribute("allCards", allCards);
		request.getRequestDispatcher("setpurchase.jsp").forward(request, response);
		
	}

}
