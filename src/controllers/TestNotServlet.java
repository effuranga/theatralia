package controllers;


public class TestNotServlet {
	public static void main(String[] args) {
	
		String text = "Texto de prueba. 5687";
		String sinPunc = text.replaceAll("[^\\w]", "");
		System.out.println(sinPunc);
		String[] result = text.split("\\W+");
		for(String s: result) System.out.println(s+" ");
		
	}
}