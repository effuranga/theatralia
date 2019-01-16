<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="utils.Header"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
ArrayList<Play> playsResult = (ArrayList<Play>)request.getAttribute("playsResult");
boolean toShow = (playsResult != null && !playsResult.isEmpty())? true : false;
%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Resultados</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">


  </head>

  <body>

    <%=Header.getHeader(loggedUser, "searchplay") %>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4" style="margin-bottom: unset!important;">Resultados para: 
        <small><%=request.getParameter("q") %></small>
      </h1>
      <a class="btn btn-primary" href="search.jsp" style="margin-bottom: 10px;">Volver</a>

<%
if(toShow){
	for(Play p : playsResult){
	%>
      <!-- Play -->
      <div class="row">
        <div class="col-md-7">
          <a href="#">
            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=p.imageSRC() %>" alt="">
          </a>
        </div>
        <div class="col-md-5">
          <h3><%=p.getName() %></h3>
          <p><%=p.getDescription() %></p>
          <a class="btn btn-primary" href="viewplay?id=<%=p.getId()%>">Ver obra</a>
        </div>
      </div>
      <hr> <!-- Esta linea divide las obras -->		
<%	}
}
else{
%>
	<p>No se han encontrado coincidencias</p>
<%
}
%>


    </div>
    <!-- /.container -->



    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
