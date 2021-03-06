package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.UserHandler;
import utils.FileExistenceValidator;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserHandler userHandler = new UserHandler();
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		if(userName == null || userName.isEmpty() || password == null || password.isEmpty()) {
			response.sendRedirect("home");
			return;
		}
		
		User loggedUser = userHandler.getLoggedUser(userName, password);
		HttpSession session = request.getSession();
		session.setAttribute("loggedUser", loggedUser);
		
		if(loggedUser != null) {
			if(loggedUser.getStatus() != 1) {
				//El usuario no esta activo
				session.setAttribute("loggedUser", null);
				response.sendRedirect("home?inactive=true");
				return;
			}
			//LOGGEO EXITOSO
			System.out.println(loggedUser.getRole());
			//Para el manejo de imagenes
			FileExistenceValidator.setAbsolutePath(request.getServletContext().getRealPath(""));
			response.sendRedirect("home");
		}
		else {
			//LOGGEO FALLIDO
			response.sendRedirect("home?falseauth=true");
		}
		
		
	}
	

}
