package utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateHandler {
	
	/**
	 * Devuelve el DATE actual a las 00:00:00.000
	 * @return actualDate
	 */
	public Date getSimpleCurrentDate() {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String actualDateString = format.format(new Date());
		Date actualDate = new Date();
		try {
			actualDate = new SimpleDateFormat("yyyy-MM-dd").parse(actualDateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println("recibo "+actualDateString+" y me queda la date: "+actualDate);
		return actualDate;
	}
	
	/**
	 * Devuelve el DATE que resulta de transformar el String - en formato sql - a las 00:00:00.000
	 * @param dateString
	 * @return date
	 */
	public Date getSimpleDate(String dateString) {
		Date date = new Date();
		try {
			date = new SimpleDateFormat("yyyy-MM-dd").parse(dateString);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println("recibo "+dateString+" y me queda la date: "+date);
		return date;
	}
	

	/**
	 * Devuelve true si la fecha argumento es igual o mayor a la actual (Solo considerando el dia)
	 * @param date
	 * @return
	 */
	public boolean isAFutureDate(String date) {
		Date currentDate = getSimpleCurrentDate();
		Date showDate = getSimpleDate(date);
		if(showDate.compareTo(currentDate) < 0) {
			System.out.println("la fecha es anterior");
			return false;
		}
		System.out.println("la fecha es posterior");
		return true;
	}
	
	/**
	 * A partir de un String date sacado de SQL, parsea SOLO SU FECHA en formato dd/mm/aaaa
	 * @param dateString
	 * @return dateHTML Ej: 31/12/2010
	 */
	public String getHTMLDate(String dateString) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date;
		try {
			date = format.parse(dateString);
			String dateHTML = new SimpleDateFormat("dd/MM/yyyy").format(date);		
			return dateHTML;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return "00/00/0000";
	}
	
	/**
	 * A partir de un String date sacado de SQL, parsea SOLO SU HORMA en formato HH:mm
	 * @param dateString
	 * @return dateHTML Ej: 15:21
	 */
	public String getHTMLTime(String dateString) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date;
		try {
			date = format.parse(dateString);
			String dateHTML = new SimpleDateFormat("HH:mm").format(date);		
			return dateHTML;
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		return "00:00";
	}
	
	/**
	 * A partir de un Date sacado de SQL, parsea SOLO SU FECHA en formato dd/mm/aaaa
	 * @param dateString
	 * @return dateHTML Ej: 31/12/2010
	 */
	public String getHTMLDate(Date date) {
		String dateHTML = new SimpleDateFormat("dd/MM/yyyy").format(date);		
		return dateHTML;
	}
}
