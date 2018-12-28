<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Show"
    import="business.User"%>
<%
// ACA YA ME LLEGA LA OBRA SIN SHOWS PASADOS, NI SHOWS QUE NO TENGAN ASIENTOS

Play play = (Play) request.getAttribute("play");
User loggedUser = (User) session.getAttribute("loggedUser");

// Data por si tengo que vender
ArrayList<Show> shows = play.getShows();
if(!shows.isEmpty()) System.out.println("No esta vacio. Tiene shows");
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

	<!-- Scroll -->
	<link rel="stylesheet" href="scrollFE/css/style.css">
	
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
            <li class="nav-item">
              <a class="nav-link" href="home">Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="logout">Salir</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>
    
    
<div id="page">
  <section class="one">
    <div>
    	<!-- Page Content -->
	    <div class="container">
	
	      <!-- Page Heading -->
	      <h1 class="my-4">Obras
	        <small></small>
	      </h1>
	
	
	      <!-- Play -->
	      <div class="row">
	        <div class="col-md-7">
	          <a href="#">
	            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 400px; width: 300px" src="https://www.cerritos.edu/theater/_includes/images/2017-18/R_J_Poster_Cerritos_550.jpg" alt="">
	          </a>
	        </div>
	        <div class="col-md-5">
	          <h3><%=play.getName() %></h3>
	          <p><%=play.getDescription() %></p>
	<%		if(loggedUser.isClient()) {
	          if(play.getStatus()==1 && play.hasShowsInTheFuture()) {%><a class="btn btn-primary" href="setpurchase?id=<%=play.getId() %>">Comprar</a> <%}%>    	 
	 <%			if(!(boolean) request.getAttribute("addedInLibrary")){ %>
		 			<a class="btn btn-primary" href="addtolibrary?playId=<%=play.getId() %>">(+)Biblioteca</a>
	<%			}
	 			else{%>
	 				<a class="btn btn-secondary" href="removefromlibrary?playId=<%=play.getId() %>">(-)Biblioteca</a>
	<%			}
			} 
			else{
		      	if(play.getStatus()==1 && play.hasShowsInTheFuture()) {%>             
		          <form action="sell" method="get">
		          	<select name="showId" required>
	<%         			for(Show s : shows){
	%>						<option value="<%=s.getId()%>"><%=s.getDate()%></option>
	<%        			}%>          		
					</select>
					<input type="hidden" name="id" value="<%=play.getId() %>">
					<input type="submit" class="btn btn-primary" value="Vender" />	
		          </form>
	<% 			}
			}%>          
	        </div>
	      </div>
	      <hr> <!-- Esta linea divide las obras -->		
	
	
	
	    </div>
	    <!-- /.container -->
    </div>
    <img class="next" src="utils/arrow_down.svg" height="55px" width="55px"></img>
  </section>
  <section class="two">
    <div>Comentarios</div>
    <img class="next" src="utils/arrow_down.svg" height="55px" width="55px"></img>
  </section>
  <section class="three">
    <div>Quien los tiene en biblioteca</div>
  </section>
</div>
			

   

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Scroll -->
	<script  src="scrollFE/js/index.js"></script>

  </body>

</html>
