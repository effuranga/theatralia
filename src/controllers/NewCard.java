package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.CardHandler;

/**
 * Servlet implementation class NewCard
 */
@WebServlet("/newcard")
public class NewCard extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User loggedUser = (User) request.getSession().getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		String type, number, name, description, exp_month, exp_year;
		type = request.getParameter("type");
		number = request.getParameter("number");
		name = request.getParameter("name");
		description = request.getParameter("description");
		exp_month = request.getParameter("exp_month");
		exp_year = request.getParameter("exp_year");
		
		CardHandler cardHandler = new CardHandler();
		
		boolean goodFieldsFormat = cardHandler.validateNewCardFields(type, number, name, description, exp_month, exp_year);
		
		//Validación del formato de los campos y luego del salvado en la DB
		if(!goodFieldsFormat) {
			request.setAttribute("message", "Los datos ingresados no son validos");
		}
		else {
			boolean insert = cardHandler.saveCard(type, number, name, description, exp_month, exp_year, loggedUser.getUserId());
			if(insert) {
				request.setAttribute("message", "Su tarjeta se ha cargado con exito");
			}
			else {
				request.setAttribute("message", "La transacción no se ha podido realizar");
			}
		}
		RequestDispatcher rs = request.getRequestDispatcher("validation.jsp?action=1");
		rs.forward(request, response);
	}

}
