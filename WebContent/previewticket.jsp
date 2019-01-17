<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Seat"
    import="business.Show"
    import="business.User"
    import="utils.DateHandler"
    import="business.Ticket"%>
<%
User loggedUser = (User) request.getSession().getAttribute("loggedUser");
if(loggedUser.isClient()){
	response.sendRedirect("error.jsp?e=Sos cliente");
	return;
}
Ticket ticket = (Ticket)request.getAttribute("ticket");
Play play = ticket.getPlay(); 
User user = ticket.getUser();

DateHandler dh = new DateHandler();
%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <title>Preview ticket</title>
    
    <!-- Ticket -->
    <link rel="stylesheet" href="ticketFE/css/style.css">

  </head>

  <body>        
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
		            String client = user.getLastName()+", "+user.getName();
		            %>
		              <h2 class="name">Cliente</h2><span class="value"><%=client %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String seller = loggedUser.getLastName()+", "+loggedUser.getName();
		            %>
		              <h2 class="name">Vendedor</h2><span class="value"><%=seller %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		    <%String card = retrieveCardString(ticket.getCard().getNumber()); %>
		              <h2 class="name">Tarjeta Nro.</h2><span class="value"><%=card %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Función</h2><span class="value"><%=dh.getHTMLDateAndTime(ticket.getShow().getDate()) %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Emisión</h2><span class="value"><%=dh.getHTMLDateAndTime(ticket.getBuyingDate()) %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		              <h2 class="name">Total</h2><span class="value">$<%=ticket.getTotal() %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String status = "";
		            status = (ticket.isPaid())? "Pagado" : "Pago pendiente en boleteria";
		            %>
		              <h2 class="name">Estado</h2><span class="value"><%=status %></span>
		            </div>
		          </div>
		          <div class="col">
		            <div class="item">
		            <%
		            String deliveryCode = ticket.getDeliveryCode();
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
		        <h2 class="name">Precio</h2><span class="value">$<%=seats.get(0).getPrice() %></span>
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
		        <span class="value">$<%=s.getPrice() %></span>
		      </div>
		    </div>
		<%	} %>    
		    
		  </div><!-- Ticket body -->		
	</div><!-- Ticket -->	
	
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
