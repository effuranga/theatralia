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
//Verificación de entrada por links
String changeDataRequested = (String) request.getParameter("changeData");
String changeImageRequested = (String) request.getParameter("changeImage");
String changePassRequested = (String) request.getParameter("changePass");
boolean changeData = false;
boolean changeImage = false;
boolean changePass = false;
boolean regular = true;
if(changeDataRequested != null && changeDataRequested.equals("true")){
	changeData = true;
}
if(changeData == false && changeImageRequested != null && changeImageRequested.equals("true")){
	changeImage = true;
}
if(changeData == false && changeImage == false && changePassRequested != null && changePassRequested.equals("true")){
	changePass = true;
}
if(changeData || changeImage || changePass){
	regular = false;
}

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>My profile</title>

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
            <li class="nav-item">
              <a class="nav-link" href="home">Programación</a>
            </li>
            <li class="nav-item active">
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
          <img src="userPictures/<%=loggedUser.getProfImage() %>" width="300px" height="300px">
          
<%         if(changeImage){
          %>
          <br/>
          <form action="updateimage" method="POST" id="updateImage" enctype="multipart/form-data">
        	  <input type="file" name="uploadFile" style="margin-top:10px; margin-bottom:10px;"/><br/>
        	  <input type="submit" class="btn btn-primary" value="Subir"/>
	          <a href="myprofile.jsp" class="btn btn-secondary">Cancelar</a>
          </form>
          <%
          }
		else{ %>
		 <a href="myprofile.jsp?changeImage=true">Cambiar imagen</a><br/>
<%		}
%>
        </div>
        <div id="info" style="
          float:left;
          width: 70%;
          height: 100%;
          padding:10px;
          ">
          <%
          if(request.getParameter("message")!= null){
        	  out.println("<small style=\"color: green;\">(*)"+request.getParameter("message")+"</small>");
          }
          if(changeData){
          %>
          	<form action="updatedata" method="POST" id="updateData">
	          <h2>Actualizar datos</h2>
	          <p>Usuario: <input type="text" name="userName" id="userName" value="<%=loggedUser.getUserName() %>" /></p>
	          <p>Contraseña: ********</p>
	          <p>Nombre: <input type="text" name="name" id="name" value="<%=loggedUser.getName() %>" /></p>
	          <p>Apellido: <input type="text" name="lastName" id="lastName" value="<%=loggedUser.getLastName() %>" /></p> 
	          <p>Fecha de nacimiento: <input type="date" name="birthday" id="birthday" value="<%=loggedUser.getBirthday() %>" /></p>
	          <p>Email: <input type="text" name="email" id="email" value="<%=loggedUser.getEmail() %>" /></p>
	          <input type="submit" class="btn btn-primary" value="Actualizar"/>
	          <a href="myprofile.jsp" class="btn btn-secondary">Cancelar</a>
	        </form>
          <%
          }
          if(changePass){
          %>
          <form action="updatepassword" method="POST" id="updatePassword">
        	  <h2>Cambiar contraseña</h2>
        	  <p>Nueva Contraseña: <input type="password" name="password" id="password" /></p>
        	  <p>Repetir Contraseña: <input type="password" name="password" id="password" /></p>
        	  <input type="submit" class="btn btn-primary" value="Cambiar"/>
	          <a href="myprofile.jsp" class="btn btn-secondary">Cancelar</a>
          </form>
          <%
          }
          if(regular || changeImage){
          %>
    	  	  <h2>Información Personal</h2>
	          <p>Usuario: <%=loggedUser.getUserName() %></p>
	          <p>Contraseña: ********</p>
	          <p>Nombre: <%=loggedUser.getName() %></p>
	          <p>Apellido: <%=loggedUser.getLastName() %></p> 
	          <p>Fecha de nacimiento: <%=loggedUser.getBirthday()  %></p>
	          <p>Email: <%=loggedUser.getEmail() %></p>
    	  <%	  
          }
          %>

<%if(!changeData) {%>          <a href="myprofile.jsp?changeData=true">Actualizar datos</a><br/> <%} %>
<%if(!changePass) {%>          <a href="myprofile.jsp?changePass=true">Cambiar contraseña</a><br/> <%} %>
          <a href="mycards">Ver mis métodos de pago</a><br/>
        
        <%
ArrayList<String> errorList = (ArrayList<String>)request.getAttribute("errorList");
if(errorList != null){
	for(String s : errorList)
		out.println("<small style=\"color: red;\">(*)"+s+"</small><br/>");
}
%>   
        
        </div>      
    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark" style="bottom:0px; position:absolute; width:100%;">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Thetralia® 2018</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
