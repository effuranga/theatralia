package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.UserHandler;

/**
 * Servlet implementation class ChangeUserRole
 */
@WebServlet("/changeuserrole")
public class ChangeUserRole extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		User user = (User) request.getSession().getAttribute("loggedUser");
		if(user == null || !user.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Administrador) para poder realizar esta accion.");
			return;
		}
		try {
			int userId = Integer.parseInt(request.getParameter("userId"));
			int toRole = Integer.parseInt(request.getParameter("toRole"));
			
			UserHandler userHandler = new UserHandler();
			boolean valid = userHandler.changeUserRole(userId, toRole);
			
			if(valid) {
				response.sendRedirect("adminusers?action=role");
			}
			else {
				response.sendRedirect("error.jsp?e=Fallo el cambio de rol. Vuelve a intentarlo mas tarde.");
			}
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=Fallo el parseo de string a int. Someone is messing up with the code");
		}
	}

}
