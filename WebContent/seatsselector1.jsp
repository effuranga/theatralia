<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Iterator"
    import="business.Play"
    import="business.Show" 
    import="business.User"
    import="business.Seat"
    import="business.Card"
    import="utils.DTOPurchase"
    import="utils.DTOSell"
    %>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=El usuario no está loggeado");
	return;
}

Show show = (Show) request.getAttribute("show");
String action = (loggedUser.isClient())? "setpayment" : "validatesell";
// Logica horrible para distinguir los DTOs
/*
String action;
Show show = null;
if(loggedUser.isClient()){
	DTOPurchase dto = (DTOPurchase) session.getAttribute("purchase");
	action = "setpayment";
	if(dto != null) show = dto.getShow();
}
else{
	DTOSell dto = (DTOSell) session.getAttribute("purchase");
	action = "validatesell";
	if(dto != null) show = dto.getShow();
}

if(show == null){
	response.sendRedirect("error.jsp?e=Fallo la logica de distincion de DTOs en seatsselector.jsp");
	return;
}
*/
if(show == null){
	response.sendRedirect("error.jsp?e=El show no se encontro en seatsselector.jsp - desde SeatsSelector o desde Sell");
	return;
}
ArrayList<Seat> seats = show.getSeats();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Elegir asiento</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">
    
    <!-- Seats -->
    <link rel="stylesheet" href="seats/css/style.css">

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
      <h1 class="my-4">Asientos
        <small></small>
      </h1>
	
		<div class="theatre">
		    
		<!-- IMPRESION DE ASIENTOS -->
  <div class="cinema-seats left">
<% 	Iterator<Seat> iterator = seats.iterator();
	for(int i = 1; i < 8; i++){%>	 
  		
	  	<div class="cinema-row row-<%=i %>">
<%	  		for(int q = 1; q < 8; q++){
	  			Seat seat = iterator.next();
				if(seat.getStatus() == 0){%>		 
					<label for="<%=seat.getId() %>"><div class="seat"></div></label>
<%				}
				else{%>
					<div class="seat" style="background: linear-gradient(to top, #3F68BF, #19294C, #19294C, #19294C, #19294C, #3F68BF,  #3F68BF); pointer-events:none;"></div>	
<%					  	
				}	
			}%>	
	    </div>
<%	} %>	
  </div>

  <div class="cinema-seats right">
<% 	for(int i = 1; i < 8; i++){%>	 
  		
	  	<div class="cinema-row row-<%=i %>">
<%	  		for(int q = 1; q < 8; q++){
	  			Seat seat = iterator.next();
				if(seat.getStatus() == 0){%>		 
					<label for="<%=seat.getId() %>"><div class="seat"></div></label>
<%				}
				else{%>
					<label><div class="seat" style="background: linear-gradient(to top, #3F68BF, #19294C, #19294C, #19294C, #19294C, #3F68BF,  #3F68BF); pointer-events:none;"></div></label>	
<%					  	
				}	
			}%>	
	    </div>
<%	} %>	
  </div>
		
		
		<!-- FIN IMPRESION DE ASIENTOS -->      	
		    <form method="GET" action="<%=action %>">  
		      
<%			for(Seat seat : seats){ System.out.println((seat.getStatus()));
				if(seat.getStatus() == 0){%>
			  	  <input type="checkbox" name="selectedSeats" id="<%=seat.getId() %>" value="<%=seat.getId() %>" style="visibility: hidden; display: none;">
<% 				}
			}%>
		
	<br/>  <input type="submit" name="submit" class="btn btn-primary" value="Continuar">
		    </form>
		
		</div>

    </div>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Seats -->
    <script src='seats/jquery.min.js'></script>
    <script  src="seats/js/index.js"></script>

  </body>

</html>
