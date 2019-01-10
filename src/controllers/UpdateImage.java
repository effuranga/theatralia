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

import business.User;
import services.UserHandler;
import utils.ImageHandler;

/**
 * Servlet implementation class UpdateImage
 */
@WebServlet("/updateimage")
public class UpdateImage extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("rawtypes")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();        
        ServletFileUpload upload = new ServletFileUpload(factory);
        User user = (User) request.getSession().getAttribute("loggedUser");
        
        if(user == null) {
        //El usuario no está loggeado
        	response.sendRedirect("error.jsp?e=El usuario no está loggeado");
        	return;
        }	     
        try {
            // parses the request's content to extract file data
        	FileItem item;   	
			List formItems = upload.parseRequest(request);
            Iterator iterator = formItems.iterator(); 
            boolean savedImage = false;
            // iterates over form's fields
            while(iterator.hasNext()) {
               // processes only the fields on the form
            	item = (FileItem) iterator.next();
                if (!item.isFormField()) {
	            	ImageHandler imageHandler = new ImageHandler(); 
	            	savedImage = imageHandler.saveProfileImage(item, getServletContext().getRealPath(""), user.getUserId());
                }
            }  
            
            if(savedImage) { 	
            	UserHandler userHandler = new UserHandler();
            	boolean updatedInDB = userHandler.setProfImage(user.getUserId());
            	if(updatedInDB) {
            		user.setProfImage(Integer.toString(user.getUserId())+".jpg");
                	request.getSession().setAttribute("loggedUser", user);
                	response.sendRedirect("myprofile.jsp?message=La image se ha actualizado correctamente");
                	return;
            	}
            	else {
            		response.sendRedirect("error.jsp?e=La actualización de la DB no funciono");
    				return;
            	}
    		}      
            response.sendRedirect("error.jsp?e=Al parecer ocurrio un error al actualizar la imagen. Esto puede ser debido a que el archivo no es del tipo correcto .JPG/.JPEG");
        } catch (Exception ex) {
            request.setAttribute("message", "There was an error: " + ex.getMessage());
        }        
	}

}
