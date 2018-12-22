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
import utils.DTOCreateUserForm;

/**
 * Servlet implementation class CreateUser
 */
@WebServlet("/createuser")
public class CreateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=No loggead o no admin");
			return;
		}
		String userName = request.getParameter("userName");
		String password = request.getParameter("password");
		String roleId = request.getParameter("roleId");
		String name = request.getParameter("name");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String birthday = request.getParameter("birthday");
		
		DTOCreateUserForm dto = new DTOCreateUserForm(userName, password, roleId, name, lastName, email, birthday);  
		UserHandler userHandler = new UserHandler();
		ArrayList<String> errors = userHandler.createUser(dto);
		
		//chequear los metodos de validacion en cada caso por los msjs
		if(errors.isEmpty()) {
			response.sendRedirect("adminusers?action=newUser");
			return;
		}
		else {
			request.setAttribute("errors", errors);
			request.setAttribute("dto", dto);
			request.getRequestDispatcher("createuser.jsp").forward(request, response);
		}
	}

}
