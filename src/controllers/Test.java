package controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.CommentHandler;
import business.Comment;;




/**
 * Servlet implementation class Test
 */
@WebServlet("/t")
public class Test extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CommentHandler ch = new CommentHandler();
		HashMap<Integer, Comment> comments = ch.getCommentsForPlay(46);
		
		Set<Integer> ids = comments.keySet();
		for(int i : ids) {
			Comment c = comments.get(i);
			System.out.println("Padre id: "+c.getId()+" texto: "+ c.getText());
			if(c.hasChildren()) {
				ArrayList<Comment> children = c.getChildren();
				for(Comment child : children) {
					System.out.println("  Hijo id: "+child.getId()+" texto: "+ child.getText());
				}
			}
		}
        
	}
		

	

}
