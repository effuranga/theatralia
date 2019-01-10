package utils;

import java.io.File;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FilenameUtils;

public class ImageHandler {
	private static final String UPLOAD_DIRECTORY_PLAY = "playPictures";
	private static final String UPLOAD_DIRECTORY_USER = "userPictures";

	/**
	 * 
	 * @param request
	 * @param servletContextRealPath viene del Servlet que llama el argumento mandando
	 * getServletContext().getRealPath("");
	 * @param playId para ponerlo de nombre a la imagen
	 * @return true si la imagen de la obra fue guardada correctamente / false si no es el formato
	 * correcto o si hubo una excepcion y se devuelve en "message" en el request attribute
	 */
	public boolean savePlayImage(FileItem item, String servletContextRealPath, String playId) {
		boolean result = false;
		result = saveImage(item, servletContextRealPath, playId, UPLOAD_DIRECTORY_PLAY);
		
		return result;
	}
	
	/**
	 * 
	 * @param request
	 * @param servletContextRealPath viene del Servlet que llama el argumento mandando
	 * getServletContext().getRealPath("");
	 * @param userId para ponerlo de nombre a la imagen
	 * @return true si la imagen de perfil fue guardada correctamente / false si no es el formato
	 * correcto o si hubo una excepcion y se devuelve en "message" en el request attribute
	 */
	public boolean saveProfileImage(FileItem item, String servletContextRealPath, int userId) {
		boolean result = false;
		result = saveImage(item, servletContextRealPath, Integer.toString(userId), UPLOAD_DIRECTORY_USER);
		
		return result;
	}
	
	public boolean saveImage(FileItem item, String servletContextRealPath, String id, String destionation_path) {
        // constructs the directory path to store upload file
        String uploadPath = servletContextRealPath
            + File.separator + destionation_path;
        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        
    	String fileName = id + ".jpg";
        String filePath = uploadPath + File.separator + fileName;
        File storeFile = new File(filePath);
         
        // saves the file on disk
        String extension = FilenameUtils.getExtension(fileName); //TODO revisar si esto no deberia ser uploadPath o ver como ubicar el nombre del archivo, y no este param que yo mismo declaro mas arriba
        if(extension.equalsIgnoreCase("jpg") || extension.equalsIgnoreCase("jpeg") || extension.equalsIgnoreCase("png")) {
        	try {
				item.write(storeFile);
				System.out.println("Upload has been done successfully!");
				return true;
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
        }
        else {         	
        	System.out.println("Image extension es false");
        	return false;
        }         
        
    }

}
