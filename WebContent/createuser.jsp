<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="business.Play"
    import="business.User"
    import="utils.DTOCreateUserForm"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
if(!loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=No sos administrador wacho");
	return;
}

// SI tengo errores
DTOCreateUserForm dto = (DTOCreateUserForm) request.getAttribute("dto");
boolean fail = (dto != null)? true : false;

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Create User</title>

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
          <img src="https://cdn2.iconfinder.com/data/icons/users-2/512/User_16-512.png" width="300px" height="300px">
          
        </div>
        <div id="info" style="
          float:left;
          width: 70%;
          height: 100%;
          padding:10px;
          ">

          	<form action="createuser" id="form" method="POST">
	          <h2>Crear Usuario</h2>

				<input type="text" name="userName" placeholder="Username" <%if(fail){out.print("value=\""+dto.getUserName()+"\"");}%> required /><br/>
				<input type="text" name="password" placeholder="Contraseña" <%if(fail){out.print("value=\""+dto.getPassword()+"\"");}%> required /><br/>
				<label>Rol </label>
				<select name="roleId">
                  <option value="2" <%if(fail && dto.getRoleId().equals("2")){out.print("selected");}%>> Empleado</option>
                  <option value="3" <%if(fail && dto.getRoleId().equals("3")){out.print("selected");}%>> Administrador</option>
	            </select> <br/>
				<input type="text" name="name" placeholder="Nombre" <%if(fail){out.print("value=\""+dto.getName()+"\"");}%> required /><br/>
				<input type="text" name="lastName" placeholder="Apellido" <%if(fail){out.print("value=\""+dto.getLastName()+"\"");}%> required /><br/>
				<input type="text" name="email" placeholder="EMail" <%if(fail){out.print("value=\""+dto.getEmail()+"\"");}%> required /><br/>
				<label>Fecha de nac: </label><input type="date" name="birthday" <%if(fail){out.print("value=\""+dto.getBirthday()+"\"");}%> required> <br/>
				
	          <input type="submit" class="btn btn-primary" value="Cargar"/>
	          <a href="adminusers" class="btn btn-secondary">Cancelar</a>
	        </form>       
        </div>      
    </div>
    <!-- /.container -->

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<%
	if(fail){
		String message = "Inconvenientes: ";
		ArrayList<String> errors = (ArrayList<String>) request.getAttribute("errors");
		for(String s : errors){
			message += s+" /";
		}
	%>
		<script>
			function myFunction() {
			  alert("<%=message %>");
			}
			
			myFunction();
		</script>
	<%} %>	
  </body>

</html>
