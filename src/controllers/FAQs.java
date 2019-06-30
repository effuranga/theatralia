package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;

/**
 * Servlet implementation class FAQs
 */
@WebServlet("/faqs")
public class FAQs extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion para poder realizar esta accion.");
			return;
		}
		
		//Si vengo por URL
		String to = request.getParameter("to");
		if(to != null) {
			if(to.equals("c"))
				request.getRequestDispatcher("faqsc.jsp").forward(request, response);
			if(to.equals("e"))
				request.getRequestDispatcher("faqse.jsp").forward(request, response);
			if(to.equals("a"))
				request.getRequestDispatcher("faqsa.jsp").forward(request, response);
		}
		else {
			//Primer llamada desde el menu
			if(user.isClient())
				request.getRequestDispatcher("faqsc.jsp").forward(request, response);
			if(user.isEmployee())
				request.getRequestDispatcher("faqse.jsp").forward(request, response);
			if(user.isAdmin())
				request.getRequestDispatcher("faqsa.jsp").forward(request, response);
		}	
	}

}
