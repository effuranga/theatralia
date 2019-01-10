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
 * Servlet implementation class UpdatePlay
 */
@WebServlet("/updateplay")
public class UpdatePlay extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();        
        ServletFileUpload upload = new ServletFileUpload(factory);
        
        String name = "";
        String description = "";
        String author = "";
        String message = "";
        String id = request.getParameter("id");
        
        try {
            // parses the request's content to extract file data
        	FileItem item;
        	//Antes no tenia el <FilteItem>
			List<FileItem> formItems = upload.parseRequest(request);
            Iterator<FileItem> iterator = formItems.iterator(); 
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
	                		description = item.getString().trim();
	                		break;
	                	case "author":
	                		author = item.getString().trim();
	                		break;
	            	}
                }
            }  
            
          //Validate all text fields are mandatory
            if(name.isEmpty() || description.isEmpty() || author.isEmpty()) {
            	message = "Fallaron los text fields mandatory";
            	response.sendRedirect("error.jsp?message="+message);
            	return;
            } 
         	// Let's update the play
            PlayHandler playHandler = new PlayHandler();
            boolean updated = playHandler.updatePlay(id, name, description, author);
            	//Validate the play was successfully saved
            if(!updated) {
            	message = "La obra no se actualizo";
            	response.sendRedirect("error.jsp?message="+message);
            	return;
            }   
           
            boolean imageSaved = false; //en disco
            boolean imageExist = false;
            iterator = formItems.iterator();

            // locate the non-form_field
            while(iterator.hasNext()) {
            	item = (FileItem) iterator.next();
                if (!item.isFormField() && item.getSize() > 0) {
                	imageExist = true;
	            	ImageHandler imageHandler = new ImageHandler(); 
	            	imageSaved = imageHandler.savePlayImage(item, getServletContext().getRealPath(""),id);
                }
            }  
            
            if(imageExist && imageSaved) {
    			playHandler.setImage(id);
    		}
            if(imageExist && !imageSaved) {
            	message = "Al parecer ocurrio un error al actualizar la imagen. Esto puede ser debido a que el archivo no es del tipo correcto .JPG/.JPEG";
            	response.sendRedirect("error.jsp?e="+message);
            	return;
            }
            response.sendRedirect("viewplay?id="+id);      	
                     
        } catch (Exception ex) {
            message = "Ocurrio un error inesperado";
        	response.sendRedirect("error.jsp?message="+message);
            
        }        
	}
}
