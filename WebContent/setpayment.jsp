<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Show" 
    import="business.User"
    import="business.Seat"
    import="business.Card"
    import="utils.Header"
    import="utils.DTOPurchase"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
DTOPurchase dto = (DTOPurchase) session.getAttribute("purchase");

if(loggedUser == null || dto == null){
	response.sendRedirect("error.jsp?e=usuario no loggeado o dto en null");
	return;
}
Play play = dto.getPlay();
Show show = dto.getShow();
ArrayList<Seat> seats = dto.getSeats();
Card card = dto.getCard();
boolean payWithCard = dto.isPayWithCard();
float total = 0;
for(Seat s : seats){
	total += s.getPrice();
}
String delivery = (payWithCard)? "Pago con tarjeta" : "Pago por ventanilla";

//Manejo de la imagen
String imageSRC = "";
if(play.hasImage()){
	imageSRC = "playPictures/"+play.getImage();
}
else{
	imageSRC = "utils/noimage.jpg";
}

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Confirmar</title>

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
      <h1 class="my-4">Confirmar compra
        <small></small>
      </h1>


      <!-- Play -->
      <div class="row">
        <div class="col-md-7">
          <a href="#">
            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=imageSRC %>" alt="">
          </a>
        </div>
        <div class="col-md-5">
          <h3><%=play.getName() %></h3>
          <p>Funcion: <%=show.getDate() %></p><br />
          <p>Asientos:</p><br />
<% 			for(Seat s: seats){%>
			<p><%=s.getRow()+s.getColumn()+"   "+s.getPrice() %></p><br />
<%}%>
          <p>Total a abonar: <%=total %></p><br />
          <p>Saldo a cargar en tarjeta: <%if(payWithCard) out.print(total); else out.print("0.0");%></p><br />
          <p>Modalidad: <%=delivery %></p><br />
          <p>Tarjeta: <%=card.getType()+" "+card.getNumber() %></p><br /><br />
          
          <form action="confirmpurchase" method="post" >
          	<label>Nombre en la tarjeta: <input type="text" name="nameInCard" value="" class="round" required/></label><br>
	      	<label>Vcmto: <input type="number" name="exp_month" min="1" max="12" placeholder="mm" class="round" required> / <input type="number" name="exp_year" min="19" max="30" placeholder="aa" class="round" required></label><br>
	        <label>Codigo: <input type="password" name="securityCode" maxlength="3" size="3" value="" class="round" required/></label><br>	
          	<a class="btn btn-secondary" href="home">Cancelar</a>
          	<input type="submit" name="submit" class="btn btn-primary" value="Confirmar" />
          </form>
                    
          
        </div>
      </div>
      <hr> <!-- Esta linea divide las obras -->		



    </div>
    <!-- /.container -->


    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
