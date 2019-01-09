<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Seat"
    import="business.Show"
    import="business.User"
    import="utils.Header"
    import="business.Ticket"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
Ticket ticket = (Ticket)session.getAttribute("ticket");
Play play = ticket.getPlay(); 
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
    
    <!-- Ticket -->
    <link rel="stylesheet" href="ticketFE/css/style.css">

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
              <a class="nav-link" href="search.jsp"><img src="homeFE/img/search.svg" style="height:20px; width:20px;"/>Obras</a>
            </li>  
            <li class="nav-item">
              <a class="nav-link" href="searchuser.jsp"><img src="homeFE/img/search.svg" style="height:20px; width:20px;"/>Usuarios</a>
            </li>
          <%
          if(!loggedUser.isClient()){%>
        	<li class="nav-item">
              <a class="nav-link" href="delivery"><img src="homeFE/img/ticket.png" style="height:16px; width:16px;"/> Tickets</a>
            </li>  
 <%       }
          if(loggedUser.isAdmin()){
          %>
          	<li class="nav-item">
              <a class="nav-link" href="adminusers"><img src="homeFE/img/admin.png" style="height:16px; width:16px;"/> Users</a>
            </li>
          	<li class="nav-item">
              <a class="nav-link" href="adminplays"><img src="homeFE/img/admin.png" style="height:16px; width:16px;"/> Obras</a>
            </li>
          <%} 
          %>
            <li class="nav-item active">
              <a class="nav-link" href="home"><img src="homeFE/img/list.png" style="height:16px; width:16px;"/> Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="viewuser?requestedUserId=<%=loggedUser.getUserId() %>"><img src="homeFE/img/user.png" style="height:16px; width:16px;"/> <%=loggedUser.getName() %></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="logout"><img src="homeFE/img/logout.svg" style="height:16px; width:16px;"/> Salir</a>
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


   <!-- Play -->
   <div class="row">
     <div class="col-md-7">
       <a href="#">
         <img class="img-fluid rounded mb-3 mb-md-0" style="height: 900px; width: 600px" src="http://www.lineadesign.net/images/projects/batler-theater-play-poster/1272453039/standard/afisa-batler_middle.jpg" alt="">
       </a>
     </div>
        
  <!--Aca va el ticket -->
	  <div class="ticket">
		  <div class="ticket-header">
		    <div class="ticket-departure">
		      <h1 class="city-abbr">Theatralia</h1><span class="city-name"><%=play.getName() %></span>
		    </div>
		  </div>
		  <div class="ticket-body">
		    <div class="row">
		      <div class="col half">
		        <div class="row-vertical">
		         <div class="col">
		            <div class="item">
		              <h2 class="name">Ticket ID</h2><span class="value"><%=ticket.getId() %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String client = "";
		            client = (loggedUser.isClient())? loggedUser.getLastName()+", "+loggedUser.getName() : "GENERAL";
		            %>
		              <h2 class="name">Cliente</h2><span class="value"><%=client %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String seller = "";
		            seller = (loggedUser.isClient())? "WEB" : loggedUser.getLastName()+", "+loggedUser.getName();
		            %>
		              <h2 class="name">Vendedor</h2><span class="value"><%=seller %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		    <%String card = (loggedUser.isClient())? retrieveCardString(ticket.getCard().getNumber()) : "N/C"; %>
		              <h2 class="name">Tarjeta Nro.</h2><span class="value"><%=card %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Función</h2><span class="value"><%=ticket.getShow().getDate() %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Emisión</h2><span class="value"><%=ticket.getBuyingDate() %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Total</h2><span class="value"><%=ticket.getTotal() %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String status = "";
		            status = (ticket.isPaid())? "Pagado" : "Pago pendiente el boleteria";
		            %>
		              <h2 class="name">Estado</h2><span class="value"><%=status %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            float charged = 0;
		            charged = (ticket.isPaid() && loggedUser.isClient())? ticket.getTotal() : 0;
		            %>
		              <h2 class="name">Cargado en tarjeta</h2><span class="value"><%=charged %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String deliveryCode = "";
		            deliveryCode = (loggedUser.isClient())? ticket.getDeliveryCode() : "N/C";
		            %>
		              <h2 class="name">Delivery code</h2><span class="value"><%=deliveryCode %></span>
		            </div>
		          </div>
		        </div>
		      </div>
		      <div class="col half"><img class="ticket-qrcode" src="https://1.bp.blogspot.com/-tWxtTHsnBvQ/Wx0E35ydjVI/AAAAAAAAA6w/SxUTG14Kx8ABJkT4_7S18j4W-Sj5a50YACLcBGAs/s1600/qr.png" alt="Ticket Code"/></div>
		    </div><br/><br/><br/>
		    <%
		    ArrayList<Seat> seats = ticket.getSeats();
		    %>
		    <div class="row">
		      <div class="col item">
		        <h2 class="name">Fila</h2><span class="value"><%=seats.get(0).getRow() %></span>
		      </div>
		      <div class="col item">
		        <h2 class="name">Nro</h2><span class="value"><%=seats.get(0).getColumn() %></span>
		      </div>
		      <div class="col item">
		        <h2 class="name">Precio</h2><span class="value"><%=seats.get(0).getPrice() %></span>
		      </div>
		    </div>
		    <%
		    //Si hay mas de un asiento
		    seats.remove(0);
		    for(Seat s : seats){
		    %>
		    <div class="row">
		      <div class="col item">
		        <span class="value"><%=s.getRow() %></span>
		      </div>
		      <div class="col item">
		        <span class="value"><%=s.getColumn() %></span>
		      </div>
		      <div class="col item">
		        <span class="value"><%=s.getPrice() %></span>
		      </div>
		    </div>
		<%	} %>    
		    
		  </div><!-- Ticket body -->		
	</div><!-- Ticket -->	
 
 <%if(loggedUser.isClient()) {%>
 <a class="btn btn-primary" href="validate.jsp?action=2">Imprimir</a>
 <a class="btn btn-secondary" href="home" onclick="return confirm('Si desea salir sin haber impreso el ticket, recuerde anotar su delivery code. ¿Está seguro que desea continuar?');">Dashboard</a>
 <%} 
 else{%>
  <a class="btn btn-primary" href="validation.jsp?action=2">Imprimir</a> 
 <%} %>      
</div><!-- /.play -->
      <hr> <!-- Esta linea divide las obras -->		



    </div>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    

  </body>

</html>

<%! 
public String retrieveCardString(String number){
	if(number.length() >3)
		return "XXX-XXXX-"+number.substring(number.length()-4);
	else
		return number;
}
%>