package controllers;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import services.PlayHandler;
import utils.ImageHandler;

/**
 * Este servlet sirve para dar de alta las Plays
 * @author Eff
 *
 */
@WebServlet("/newplay")
@SuppressWarnings("rawtypes")
public class NewPlay extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();        
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        String name = "";
        String description = "";
        String author = "";
        String message = "";
        
        try {
            // parses the request's content to extract file data
        	FileItem item;
        	
			List formItems = upload.parseRequest(request);
            Iterator iterator = formItems.iterator(); 
            // iterates over form's fields
            while(iterator.hasNext()) {
                // processes only the fields on the form
            	item = (FileItem) iterator.next();
                if (item.isFormField()) {
	            	String itemName = item.getFieldName();        	

	            	switch(itemName) {
	                	case "name": 
	                		name = item.getString().trim();
	                		break;
	                	case "description":
	                		description = "'"+item.getString().trim()+"'";
	                		break;
	                	case "author":
	                		author = "'"+item.getString().trim()+"'";
	                		break;
	            	}
                }
            }  
            
          //Validate all text fields are mandatory
            if(name.isEmpty() || description.isEmpty() || author.isEmpty()) {
            	message = "Fallaron los text fields mandatory";
            	response.sendRedirect("newplay.jsp?message="+message);
            	return;
            } 
         	// Let's save the play
            PlayHandler playHandler = new PlayHandler();
            int id = playHandler.createPlay(name, description, author);
            	//Validate the play was successfully saved
            if(id == 0) {
            	message = "La obra no se guardó";
            	response.sendRedirect("newplay.jsp?message="+message);
            	return;
            }   
           
            boolean savedImage = false;
            iterator = formItems.iterator();

            // iterates over form's fields
            while(iterator.hasNext()) {
                // processes only the fields on the form
            	item = (FileItem) iterator.next();
                if (!item.isFormField()) {
	            	ImageHandler imageHandler = new ImageHandler(); 
	            	savedImage = imageHandler.savePlayImage(item, getServletContext().getRealPath(""), Integer.toString(id));
                }
            }  
            
            if(savedImage) {
    			playHandler.setImage(id);
    			response.sendRedirect("viewplay?id="+id);
    			return;
    		}
                     
        	message = "No se guardó la imagen";
        	response.sendRedirect("newplay.jsp?message="+message);
                     
        } catch (Exception ex) {
            message = "Ocurrio un error inesperado";
        	response.sendRedirect("newplay.jsp?message="+message);
            
        }        
	}

}
