<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="business.Play"
    import="java.util.ArrayList"
    %>
<%
Play play = (Play) session.getAttribute("playForCreatingShows");
if(play == null){
	response.sendRedirect("error.jsp");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alta shows</title>
</head>
<body>

<%=play.getId() %><br />
<%=play.getName() %><br />
<%=play.getAuthor() %><br />
<%=play.getDescription() %><br />
<%=play.getStatus() %><br />
<%=play.getImage() %><br />

<%
if(request.getAttribute("e") != null){
	%>
	<%=request.getAttribute("e") %>
<%	
	request.removeAttribute("e");
}

@SuppressWarnings("unchecked")
ArrayList<String> datesList = (ArrayList<String>) session.getAttribute("datesList");
if(datesList != null && !datesList.isEmpty()){ 
	for(String s: datesList){	
	%>
		<p><%=s %></p><br>
<%	}
}
%>

<h2>Agregar funcion</h2>
<form method="POST" action="createshow">
	<input type="datetime-local" name="showdate"> 
	<input type="submit" value="Cargar otro" name="submit"><br/>
	<input type="submit" value="Finalizar" name="submit">
</form>
</body>
</html>