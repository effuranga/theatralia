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

		User loggedUser = userHandler.getLoggedUser(userName, password);
		HttpSession session = request.getSession();
		session.setAttribute("loggedUser", loggedUser);
		System.out.println(loggedUser.getRole());
		response.sendRedirect("home");
		/*		RequestDispatcher requestDispatcher = request.getRequestDispatcher("home");
		requestDispatcher.forward(request, response);
*/	}
	

}
