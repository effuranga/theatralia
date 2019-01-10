package controllers;

import java.io.IOException;
import java.util.ArrayList;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.ShowHandler;



@WebServlet("/createshow")
public class CreateShow extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		String id = request.getParameter("id");
		String showDate = request.getParameter("showdate");
		User user = (User) request.getSession().getAttribute("loggedUser");
		
		//Validación inicial
		if(user == null || !user.isAdmin() || id == null || id.trim().isEmpty() || showDate == null || showDate.trim().isEmpty()) {
			response.sendRedirect("error.jsp?e=Fallo la validacion inicial al intentar crear la funcion");
			return;
		}
		
		ArrayList<String> datesList = new ArrayList<String>(); //para ser congruente con el metodo que acepta un batch de dates
		datesList.add(showDate);
		
		ShowHandler showHandler = new ShowHandler();
		
		try {
			int intId = Integer.parseInt(id);
			boolean savedShow = showHandler.createShowsForPlay(intId, datesList);
			if(savedShow) {
				response.sendRedirect("editplay?playid="+id);
			}
			else {
				response.sendRedirect("error.jsp?e=El show no se cargó correctamente");
			}
			
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=El id es invalido");
		}
		
		
	}
}
