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
    
    <!-- My CSS -->
    <link href="myCSS/myCSS.css" rel="stylesheet">

	<!--File button-->
    <link rel="stylesheet" type="text/css" href="fileButton/component.css" />
	<script>(function(e,t,n){var r=e.querySelectorAll("html")[0];r.className=r.className.replace(/(^|\s)no-js(\s|$)/,"$1js$2")})(document,window,0);</script>
	
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

				<input type="text" name="name" placeholder="Name of the play" class="round" required /><br/>
				<input type="text" name="description" placeholder="Description of the play" class="round" required /><br/>
				<input type="text" name="author" placeholder="Author of the play" class="round" required /><br/><br>
				<div class="box">
					<input type="file" name="uploadFile" id="uploadFile" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" style="display:none;" multiple />
					<label for="uploadFile"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> <span>Cargar imagen&hellip;</span></label>
				</div><br/>

	          <input type="submit" class="btn btn-primary" value="Cargar"/>
	          <a href="newplay.jsp" class="btn btn-secondary">Limpiar</a>
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
    
    <!-- File button-->
    <script src="fileButton/custom-file-input.js"></script>

  </body>

</html>
