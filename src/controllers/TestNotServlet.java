package controllers;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Set;

import daos.DAOComment;
import utils.DateHandler;

public class TestNotServlet {
	public static void main(String[] args) throws ParseException, SQLException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = format.parse("2018-12-27 15:30:23");
		System.out.println(date);
		System.out.println(new SimpleDateFormat("HH:mm").format(date));
		
	}
}