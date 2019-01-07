package controllers;


public class TestNotServlet {
	public static void main(String[] args) {
	
/*
		for(int i = 1, q = 1; i<=98; i++) {	
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"A\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"B\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"C\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"D\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"E\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \"F\",  "+q+",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+",  \"G\",  "+q+",  \"GENERAL\");");	
			q++;
		}
		*/
		for(int i = 1, q = 1, l=1; i<=98; i++) {	
			String letter = "";
			switch(l) {
			case 1: letter = "A"; break;
			case 2: letter = "B"; break;
			case 3: letter = "C"; break;
			case 4: letter = "D"; break;
			case 5: letter = "E"; break;
			case 6: letter = "F"; break;
			case 7: letter = "G"; break;
			
			}
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");	
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+++",  \""+letter+"\",  "+q+++",  \"GENERAL\");");
			System.out.println("INSERT INTO  `seat`(  `seatId`,  `row`,  `column`,  `description`) VALUE (  "+i+",  \""+letter+"\",  "+q+",  \"GENERAL\");");
			q=1;
			l++;
		}
		
	}
}