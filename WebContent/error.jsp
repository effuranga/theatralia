<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Error</title>
</head>
<body>
Oops, esto es vergonzoso! Ha ocurrido un error inesperado.
<a href="home">Ir al home</a> <br>

<%=request.getParameter("message") %><br>

<%=request.getParameter("e") %><br>
</body>
</html>