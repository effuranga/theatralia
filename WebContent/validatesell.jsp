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
    import="utils.DTOSell"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
DTOSell dto = (DTOSell) session.getAttribute("sell");

if(loggedUser == null || dto == null){
	response.sendRedirect("error.jsp?e=usuario no loggeado o dto en null");
	return;
}
Play play = dto.getPlay();
Show show = dto.getShow();
ArrayList<Seat> seats = dto.getSeats();
float total = 0;
for(Seat s : seats){
	total += s.getPrice();
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
    
    <!-- MyCss -->
    <link href="myCSS/myCSS.css" rel="stylesheet">

  </head>

  <body>

	<%=Header.getHeader(loggedUser, "dashboard") %>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 class="my-4">Confirmar venta
        <small></small>
      </h1>


      <!-- Play -->
      <div class="row">
        <div class="col-md-7">
          
            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=play.imageSRC() %>" alt="">
          
        </div>
        <div class="col-md-5">
          <h3><%=play.getName() %></h3>
          <p class="mytitle"><i>Funcion</i> <p style="text-decoration: none;" class="subtitle"><%=show.getDate() %></p></p>
          <p class="mytitle"><i>Asientos</i></p>
<% 			for(Seat s: seats){%>
			<p class="subtitle"><%=/*s.getId()+"   "+*/"Fila: "+s.getRow()+" Columna: "+s.getColumn()+" // $"+s.getPrice() %></p>
<%}%>
          <p class="mytitle"><i>Total a abonar</i><p style="text-decoration: none;" class="subtitle"><%="$ "+total %></p></p>
          <p class="mytitle"><i>Modalidad</i> <p style="text-decoration: none;" class="subtitle">Venta por ventanilla - Entrega inmediata</p></p>
          
	
          	<a class="btn btn-secondary" href="home">Cancelar</a>
          	<a class="btn btn-primary" href="confirmsale">Confirmar</a>

                    
          
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
