package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.Seat;
import business.Show;
import business.User;
import utils.DTOSell;


/**
 * Servlet implementation class SetPayment
 */
@WebServlet("/validatesell")
public class ValidateSell extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Termino de completar el DTO con los asientos seleccionados y redirijo a la pagina de setear el pago
	 * mostrando todos los datos de la venta
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		DTOSell dto = (DTOSell) session.getAttribute("sell");
		Show show = dto.getShow();
		ArrayList<Seat> allSeats = show.getSeats();
		HashMap<Integer, Seat> allSeatsForSearch = new HashMap<Integer, Seat>();
		ArrayList<Seat> selectedSeats = new ArrayList<Seat>();
		int seatId;
		
		if(user == null || dto == null) {
			response.sendRedirect("error.jsp?e=El usuario no esta loggeado o el DTO no está definido");
			return;
		}
		
		// Recupero los asientos elegidos
		String[] seatsIds = request.getParameterValues("selectedSeats");
		if(seatsIds.length == 0) {
			response.sendRedirect("error.jsp?e=Selecciona algun asiento man");
			return;
		}
		
		//Filtrar los seats seleccionados de entre todos los del show y ubicarlos en selectedSeats
		for(Seat s : allSeats) {
			allSeatsForSearch.put(s.getId(), s);
		}
		try {
			for(String s : seatsIds) {
				seatId = Integer.parseInt(s);
				selectedSeats.add(allSeatsForSearch.get(seatId));
			}
		}
		catch(NumberFormatException e){
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Hubo un problema con los seats ids");
			return;
		}
		//Fijarme una vez más que no quede vació el selectedSeats
		if(selectedSeats.isEmpty()) {
			response.sendRedirect("error.jsp?e=selectedSeats esta vacio");
			return;
		}
		
		// Agregarlos al DTO
		dto.setSeats(selectedSeats);
		session.setAttribute("purcahse", dto);
		
		response.sendRedirect("validatesell.jsp");
		
	}

}
