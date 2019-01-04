package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.UserHandler;

/**
 * Servlet implementation class SearchUser
 */
@WebServlet("/searchuser")
public class SearchUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null) {
			response.sendRedirect("error.jsp?e=Accedi al servlet sin estar loggeado");
			return;
		}
		
		if(request.getParameter("q") == null) {
			response.sendRedirect("home");
			return;
		}
		
		if(request.getParameter("q").trim().isEmpty()) {
			response.sendRedirect("searchuser.jsp?action=nowords");
			return;
		}
		
		String[] words = request.getParameter("q").split("\\W+");
		UserHandler userHandler = new UserHandler();
		ArrayList<User> usersResult = userHandler.getUsersBySearch(words);
		
		for(User u : usersResult) {
			System.out.println(u.getUserId());
		}
		
		request.setAttribute("usersResult", usersResult);
		request.getRequestDispatcher("searchusersresult.jsp").forward(request, response);
	}

}
