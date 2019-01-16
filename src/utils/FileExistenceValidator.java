package utils;

import java.io.File;

public class FileExistenceValidator {
	
	private static String absolutePath;
	
	/**
	 * Usa paths absoulutos para checkear si el archivo existe, en este caso la imagen de usuario
	 * @param fileName
	 * @return TRUE si el archivo existe en userPictures dentro del contexto del Servlet, sino FALSE
	 */
	public static boolean userImageExists(String fileName) {
		File f = new File(absolutePath+"userPictures\\"+fileName);
		return f.exists();
	}
	
	/**
	 * Usa paths absoulutos para checkear si el archivo existe, en este caso la imagen de obra
	 * @param fileName
	 * @return TRUE si el archivo existe en userPictures dentro del contexto del Servlet, sino FALSE
	 */
	public static boolean playImageExists(String fileName) {
		File f = new File(absolutePath+"playPictures\\"+fileName);
		return f.exists();
	}
	
	public static void setAbsolutePath(String path) {
		absolutePath = path;
	}
}
