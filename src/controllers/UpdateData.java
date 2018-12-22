package controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.UserHandler;

/**
 * Servlet called from myprofile.jsp
 * updateData form
 */
@WebServlet("/updatedata")
public class UpdateData extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loggedUser");
		
		if(user == null) {
			response.sendRedirect("error.jsp?e=El usuario no está en la sesión");
			return;
		}
		
		//Empiezo a atajar los valores de los campos
		String userName = request.getParameter("userName");
		String name = request.getParameter("name");
		String lastName = request.getParameter("lastName");
		String birthday = request.getParameter("birthday");
		String email = request.getParameter("email");
		
		UserHandler userHandler = new UserHandler();
		
		ArrayList<String> errorList = userHandler.validateUpdateFields(user.getUserId(), userName, name, lastName, birthday, email);
		
		if(errorList.isEmpty()) {
			boolean success = userHandler.updateUserFields(user.getUserId(), userName, name, lastName, birthday, email);
			if(success) {
				user.setUserName(userName);
				user.setName(name);
				user.setLastName(lastName);
				user.setBirthday(Date.valueOf(birthday));
				user.setEmail(email);
				response.sendRedirect("myprofile.jsp?message=Los datos se han actualizado correctamente");
				return;
			}
			response.sendRedirect("error.jsp?e=Ocurrio un error en la actualización de campos");
			
		}
		else {
			
			request.setAttribute("errorList", errorList);
			RequestDispatcher requestDispatcher = request.getRequestDispatcher("myprofile.jsp?changeData=true");
			requestDispatcher.forward(request, response);
		}
	}

}
