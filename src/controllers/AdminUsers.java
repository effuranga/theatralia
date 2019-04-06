package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import business.User;
import services.UserHandler;
import utils.DateHandler;

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
		
		// Export?
		boolean export = (request.getParameter("export") != null && request.getParameter("export").equals("true"));
		if(!export) {
			request.setAttribute("allUsers", allUsers);
			request.getRequestDispatcher("adminusers.jsp").forward(request, response);
		}
		else {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "filename=Lista de usuarios.xls");
			
			PrintWriter out = response.getWriter();
			try {
				DateHandler dh = new DateHandler();
				out.println("ID\tUser name\tApellido, Nombre\tEmail\tStatus\tRol\tAlta");
				for(User u : allUsers) {
					String userId = ""+u.getUserId();
					String userName = u.getUserName();
					String fullName = u.getLastName()+", "+u.getName();
					String email = u.getEmail();
					String status = (u.getStatus()==0)? "Desactivado" : ((u.getStatus()==1)? "Activo" : "Pendiente");
					String role = (u.isClient())? "Cliente" : ((u.isEmployee())? "Vendedor" : "Administrador");
					String creationDate = dh.getHTMLDate(u.getCreated())+" "+dh.getHTMLTime(u.getCreated());
					
					out.println(userId+"\t"+userName+"\t"+fullName+"\t"+email+"\t"+status+"\t"+role+"\t"+creationDate);
				} 
				
			}
			finally {
				out.close();
			}
		}
	}

}
