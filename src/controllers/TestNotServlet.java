package controllers;

import java.text.ParseException;


import utils.DateHandler;

public class TestNotServlet {
	public static void main(String[] args) throws ParseException {
	
		DateHandler dateHandler = new DateHandler();
		System.out.println(dateHandler.isAFutureDate("1/ 8/2018 11:22:00"));
		
	
		
	}
}
