package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.UserHandler;

/**
 * Servlet implementation class Signin
 */
@WebServlet("/signin")
public class Signin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Doy de alta un usuario CLIENTE por la web
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String repPassword = request.getParameter("repPassword");
		String name = request.getParameter("name");
		String lastName = request.getParameter("lastName");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		
		UserHandler userHandler = new UserHandler();
		ArrayList<String> errorsList = userHandler.validateSignInFields(userName, password, repPassword, name, lastName, birthday, email);
		if(errorsList.isEmpty()) {
			System.out.println("no hay error");
			boolean valid = userHandler.signIn(userName, password, name, lastName, birthday, email);
			if(valid) {
				boolean roleValid = userHandler.insertRole(userName, 1);
				if(roleValid) {
					response.sendRedirect("dashboard");
				}
				else {
					response.sendRedirect("error.jsp?e=No se pudo setear el rol");
				}
			}
			else {
				response.sendRedirect("error.jsp?e=No pude darlo de alta");
			}
		}
		else {
			System.out.println(" hay error");
			request.setAttribute("errorsList", errorsList);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("signin.jsp");
			requestDispatcher.forward(request, response);
		}
		
	}

}
