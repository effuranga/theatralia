package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;




/**
 * Servlet implementation class Test
 */
@WebServlet("/t")
public class Test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//	System.out.println(request.getParameter("check"));
		String[] check = request.getParameterValues("selectedSeats");
		
		for(String s : check) {
			System.out.println(s);
		}
        
	}
		

	

}
