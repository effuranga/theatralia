<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.Collection"
    import="business.Play"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
HashMap<Integer, Play> currentPlays = (HashMap<Integer, Play>)request.getAttribute("currentPlays");
boolean toShow = (currentPlays != null && !currentPlays.isEmpty())? true : false;
%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">

  </head>

  <body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="home">Theatralia</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
          <%
          if(!loggedUser.isClient()){%>
        	<li class="nav-item">
              <a class="nav-link" href="delivery">Tickets</a>
            </li>  
 <%       }
          if(loggedUser.isAdmin()){
          %>
          	<li class="nav-item">
              <a class="nav-link" href="adminusers">Admin Users</a>
            </li>
          	<li class="nav-item">
              <a class="nav-link" href="adminplays">Admin Obras</a>
            </li>
          	<li class="nav-item">
              <a class="nav-link" href="newplay.jsp">Nueva obra</a>
            </li>
          <%} 
          if(loggedUser.isClient()){%>  
        	<li class="nav-item">
              <a class="nav-link" href="library">Biblioteca</a>
            </li>
       <% }
          %>
            <li class="nav-item active">
              <a class="nav-link" href="home">Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="myprofile.jsp"><%=loggedUser.getName() %></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="logout">Salir</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Obras
        <small></small>
      </h1>

<%
if(toShow){
	Collection<Play> plays = currentPlays.values();
	for(Play p : plays){%>
      <!-- Play -->
      <div class="row">
        <div class="col-md-7">
          <a href="#">
            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%="playPictures/"+p.getImage() %>" alt="">
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
	<p>No hay obras disponibles actualmente</p>
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
