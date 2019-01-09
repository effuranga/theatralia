<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
%>
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
              <a class="nav-link" href="search.jsp"><img src="homeFE/img/search.svg" height="20" width="20" />Obras</a>
            </li>  
            <li class="nav-item">
              <a class="nav-link" href="searchuser.jsp"><img src="homeFE/img/search.svg" height="20" width="20" />Usuarios</a>
            </li>
          <%
          if(!loggedUser.isClient()){%>
        	<li class="nav-item">
              <a class="nav-link" href="delivery"><img src="homeFE/img/ticket.png" height="16" width="16" /> Tickets</a>
            </li>  
 <%       }
          if(loggedUser.isAdmin()){
          %>
          	<li class="nav-item">
              <a class="nav-link" href="adminusers"><img src="homeFE/img/admin.png" height="16" width="16" /> Users</a>
            </li>
          	<li class="nav-item">
              <a class="nav-link" href="adminplays"><img src="homeFE/img/admin.png" height="16" width="16" /> Obras</a>
            </li>
          <%} 
          %>
            <li class="nav-item active">
              <a class="nav-link" href="home"><img src="homeFE/img/list.png" height="16" width="16" /> Programación</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="viewuser?requestedUserId=<%=loggedUser.getUserId() %>"><img src="homeFE/img/user.png" height="16" width="16" /> <%=loggedUser.getName() %></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="logout"><img src="homeFE/img/logout.svg" height="16" width="16" /> Salir</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>