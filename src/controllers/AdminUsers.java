package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.UserHandler;

/**
 * Servlet implementation class AdminUsers
 */
@WebServlet("/adminusers")
public class AdminUsers extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como administrador) para poder realizar esta accion.");
			return;
		}
		
		UserHandler userHandler = new UserHandler();
		ArrayList<User> allUsers = userHandler.getAllUsers();
		request.setAttribute("allUsers", allUsers);
		request.getRequestDispatcher("adminusers.jsp").forward(request, response);
	}

}
