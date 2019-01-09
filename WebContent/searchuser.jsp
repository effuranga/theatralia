<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
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
%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Search</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">

    <!-- Search -->    
    <link rel="stylesheet" href="searchFE/css/style.css">

  </head>
  
  <style>
	  body  {
	  background-image: url("homeFE/img/audience.jpg");
	   /* Full height */
	  height: 100%; 
	
	  /* Center and scale the image nicely */
	
	  background-repeat: no-repeat;
	  background-size: cover;
	}
  </style>

  <body>

    <%=Header.getHeader(loggedUser, "searchuser") %>

    <!-- Page Content -->
    <div class="container">

     
    </div>
    <!-- /.container -->
	<div class="searchbox">
		<form method="get" action="searchuser">
		  <input type="text" name="q" placeholder="Buscar..." autocomplete="off" required />
		  <input type="submit" style="display: none;" />
		  <div class="search"></div>
		</form>
	</div>
	
	

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    
    <!-- Mensajes de alerta -->
    <%
    String action = request.getParameter("action");
    boolean pop = (action != null)? true : false;
    String message = "";
    if(pop){
	    switch(action){
	    	case "nowords":
	    		message = "Debes ingresar algo mas que espacios";
	    		break;
	    }
    %>
	    <script>
			function myFunction() {
			  alert("<%=message %>");
			}
			
			myFunction();
		</script>
<%  } %>		

  </body>

</html>
