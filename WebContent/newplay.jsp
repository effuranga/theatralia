<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="business.Play"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
if(!loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=No sos administrador wacho");
	return;
}%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create Play</title>

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
          if(loggedUser.isAdmin()){
          %>
          	<li class="nav-item active" >
              <a class="nav-link" href="newplay.jsp">Nueva obra</a>
            </li>
          <%} %>
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
    <div class="container" >
        <div id="image" style="
          float:left;
          width: 30%;
          height: 100%;
          padding:10px;
        ">
          <img src="utils/noimage.jpg" width="300px" height="300px">
          
        </div>
        <div id="info" style="
          float:left;
          width: 70%;
          height: 100%;
          padding:10px;
          ">

          	<form action="newplay" id="form" method="POST" enctype="multipart/form-data">
	          <h2>Cargar obra</h2>

				<input type="text" name="name" placeholder="Name of the play" required /><br/>
				<input type="text" name="description" placeholder="Description of the play" required /><br/>
				<input type="text" name="author" placeholder="Author of the play" required /><br/>
				Select image (jpg/png) to upload: <input type="file" name="uploadFile" required /><br/>

	          <input type="submit" class="btn btn-primary" value="Cargar"/>
	          <a href="newplay.jsp" class="btn btn-secondary">Cancelar</a>
	        </form>
        <%
if(request.getParameter("message") != null){
		out.println("<small style=\"color: red;\">(*)"+request.getParameter("message")+"</small><br/>");
}
%>   
        
        </div>      
    </div>
    <!-- /.container -->

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
