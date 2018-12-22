<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="business.Play"
    import="business.Show"
    import="business.User"%>
<%
//Validaciones pertinentes para acceder al jsp
User user = (User) session.getAttribute("loggedUser");
Play play = (Play) request.getAttribute("play");
if(user == null || play == null || !user.isAdmin()){
	response.sendRedirect("error.jsp");
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

    <title>Edit Play</title>

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
          if(user.isAdmin()){
          %>
          	<li class="nav-item active" >
              <a class="nav-link" href="newplay.jsp">Nueva obra</a>
            </li>
          <%} %>
            <li class="nav-item">
              <a class="nav-link" href="home">Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="myprofile.jsp"><%=user.getName() %></a>
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
          <img src="<%="playPictures/"+play.getImage() %>" width="300px" height="300px">
          
        </div>
        <div id="info" style="
          float:left;
          width: 70%;
          height: 100%;
          padding:10px;
          ">

          	<form action="updateplay?id=<%=play.getId() %>" id="form" method="POST" enctype="multipart/form-data">
	          <h2>Editar obra</h2>

				<input type="text" name="name" placeholder="Name of the play" value="<%=play.getName() %>" required /><br/>
				<input type="text" name="description" placeholder="Description of the play" value="<%=play.getDescription() %>" required /><br/>
				<input type="text" name="author" placeholder="Author of the play" value="<%=play.getAuthor() %>" required /><br/>
				Actualizar imagen (jpg/png): <input type="file" name="uploadFile" /><br/>

	          <input type="submit" class="btn btn-primary" value="Editar"/>
	          <a href="adminplays" class="btn btn-secondary">Cancelar</a><br>
	          
	        </form>
        
        	<form action="createshow?id=<%=play.getId() %>" method="POST" >
        		<input type="datetime-local" name="showdate" required> 
        		<input type="submit" class="btn btn-primary" onclick="return confirm('Si ha editado la obra y aún no ha hecho click en Editar, se perderán los cambios. ¿Está seguro que desea continuar?');" value="Cargar show"" >
        	</form>
        
        
        </div>      
        
        <%
        ArrayList<Show> shows = play.getShows();
        if(!shows.isEmpty()){
        	for(Show s : shows){
        		out.println(s.getDate());
        	}
        }
        %>
    </div>
    <!-- /.container -->

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>