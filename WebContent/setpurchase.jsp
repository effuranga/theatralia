<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Card"
    import="business.Show"
    import="utils.Header" 
    import="utils.DateHandler" 
    import="business.User"%>
<%
Play play = (Play) request.getAttribute("play");
ArrayList<Card> allCards = (ArrayList<Card>) request.getAttribute("allCards");
User loggedUser = (User) session.getAttribute("loggedUser");

ArrayList<Show> shows = play.getShows();
DateHandler dh = new DateHandler();

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

	<!-- myCSS -->
    <link href="myCSS/myCSS.css" rel="stylesheet">
    
  </head>

  <body>
 
	<%=Header.getHeader(loggedUser, "dashboard") %>

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
            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=play.imageSRC() %>" alt="">
          </a>
        </div>
        <div class="col-md-5">
          <h3><%=play.getName() %></h3>
          <p><%=play.getDescription() %></p>
          
          <!-- Form para settings de compras -->
          <form action="seatsselector" method="GET">
          	<label for="showId">Funcion</label>
          		<select name="showId" class="round" required>
<%         			for(Show s : shows){
%>						<option value="<%=s.getId()%>"><%=dh.getHTMLDate(s.getDate())+" "+dh.getHTMLTime(s.getDate())%></option>
<%        			}%>          		
				</select>
				<br/>
<!-- 			<label for="cantSeats">Cantidad</label>
          		<select name="cantSeats" class="round" required>
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>      		
				</select>
				<br/>	 -->
			<label for="delivery">Medio de pago</label>
          		<select name="delivery" class="round" required>
						<option value="1">Pagar con tarjeta</option>
						<option value="2">Pagar por ventanilla</option>   		
				</select>
				<br/>	
<!-- 			<label for="card">Elegir tarjeta(*)</label>
          		<select name="card" class="round" required>
<%         			for(Card c : allCards){
					   if(c.getStatus()==1) {
%>						<option value="<%=c.getId()%>"><%=c.getType()+" "+c.getNumber()%></option>
<%        				}
					}%> 		
				</select>
				<p><small>(*)La tarjeta quedara asociada a la compra aun cuando se elija "Pagar por ventanilla". Se cargará $0 a la tarjeta. En caso de no retirar la entrada abonando en persona, se cargará a dicha tarjeta el monto real de la transaccion.</small></p>
				<br/>	-->	
			 <input type="submit" class="btn btn-primary" value="Continuar" />		
          </form>
         
        </div>
      </div>
    </div>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
