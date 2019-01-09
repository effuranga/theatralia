<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Iterator"
    import="business.Play"
    import="business.Show" 
    import="business.User"
    import="business.Seat"
    import="business.Card"
    import="utils.Header"
    %>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=El usuario no está loggeado");
	return;
}

Show show = (Show) request.getAttribute("show");
String action = (loggedUser.isClient())? "setpayment" : "validatesell";

if(show == null){
	response.sendRedirect("error.jsp?e=El show no se encontro en seatsselector.jsp - desde SeatsSelector o desde Sell");
	return;
}
ArrayList<Seat> seats = show.getSeats();

if(seats == null || seats.size() != 98){
	response.sendRedirect("error.jsp?e=Hubo un problema con los asientos");
	return;
}

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
  
  <style>
  	label {
  	all: unset;	
	}
	  body  {
	  background-image: url("homeFE/img/stage.jpg");
	   /* Full height */
	  height: 100%; 
	
	  /* Center and scale the image nicely */
	
	  background-repeat: no-repeat;
	  background-size: cover;
	}
	.noselect {
  -webkit-touch-callout: none; /* iOS Safari */
    -webkit-user-select: none; /* Safari */
     -khtml-user-select: none; /* Konqueror HTML */
       -moz-user-select: none; /* Firefox */
        -ms-user-select: none; /* Internet Explorer/Edge */
            user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}
  </style>
 
<%=Header.getHeader(loggedUser, "dashboard") %>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Asientos
        <small></small>
      </h1>
	
		  <div class="theatre">
  <% 	Iterator<Seat> iterator = seats.iterator();
  		Seat seat = iterator.next();
  		String taken = "style=\"background: linear-gradient(to top, #3F68BF, #19294C, #19294C, #19294C, #19294C, #3F68BF,  #3F68BF); pointer-events:none;\"";
  %>
  <div class="cinema-seats left">
  <div class="cinema-row row-1">
  	  <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;"></div>
  	  <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;"></div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">A</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">B</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">C</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">D</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">E</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">F</div>
      <div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">G</div>
    </div>
    <div class="cinema-row row-1">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">1</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-2">
   	  <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">2</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
	
	<div class="cinema-row row-3">
	  <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
	  <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">3</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-4">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">4</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-5">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">5</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-6">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">6</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-7">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">7</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
  </div>


  <div class="cinema-seats right">
    <div class="cinema-row row-1">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">8</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-2">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">9</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
	
	<div class="cinema-row row-3">
	  <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
	  <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">10</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-4">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">11</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-5">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">12</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-6">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">13</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
    </div>
    
    <div class="cinema-row row-7">
      <label><div class="seat" style="background: unset; box-shadow: unset; pointer-events:none;"></div></label>
      <label><div class="seat noselect" style="background: unset; box-shadow: unset; pointer-events:none;">14</div></label>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label><%seat = iterator.next();%>
      <label <%if(seat.getStatus() == 0){ %>for="<%=seat.getId() %>"<%} %>><div class="seat" <%if(seat.getStatus() != 0) out.print(taken); %>></div></label>
    </div>
  </div>


    </div>
    <!-- /.container -->
 <form method="GET" action="<%=action %>">  
		      
<%			for(Seat s : seats){ 
				if(s.getStatus() == 0){%>
			  	  <input type="checkbox" name="selectedSeats" id="<%=s.getId() %>" value="<%=s.getId() %>" style="visibility: hidden; display: none;">
<% 				}
			}%>
		
	<br/>  <input type="submit" name="submit" class="btn btn-primary" value="Continuar">
		    </form>

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Seats -->
    <script src='seats/jquery.min.js'></script>
    <script  src="seats/js/index.js"></script>

  </body>

</html>
