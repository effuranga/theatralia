<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="business.Play"
    import="business.Comment"
    import="java.util.Set"
    import="utils.DateHandler"
    import="utils.Header"
    import="business.User"%>
<%
//El usuario loggeado
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}

//El usuario requested
User requestedUser = (User) request.getAttribute("requestedUser");
if(requestedUser == null) {
	response.sendRedirect("error.jsp?e=No existe tal usuario");
	return;
}

boolean isMe = false;
if(requestedUser.getUserId() == loggedUser.getUserId()){
	isMe = true;
}

//La biblioteca del usuario requested
ArrayList<Play> playList = (ArrayList<Play>) request.getAttribute("library");
boolean toShow = (playList != null && !playList.isEmpty())? true : false;

//Los comentarios del usuario
HashMap<Integer, Comment> comments = (HashMap<Integer, Comment>) request.getAttribute("comments");

DateHandler dh = new DateHandler();

//Manejo de la imagen
String imageSRC = requestedUser.imageSRC();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Usuario</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">
    
    <!-- Comment -->
    <link rel="stylesheet" href="commentFE/css/style.css">

  </head>

  <body>

    <%
    if(isMe){
    	out.print(Header.getHeader(loggedUser, "profile"));
    }
    else{
    	out.print(Header.getHeader(loggedUser, "searchuser"));
    }
    %>

    <!-- Page Content -->
    <div class="container" >
      <!-- USUARIO -->    
	   	 <div class="row">

	            <div id="image" style="
		          float:left;
		          width: 30%;
		          height: 100%;
		          padding:10px;
		        ">
		          <img src="<%=imageSRC %>" width="300px" height="300px">
		          
		        </div>
	            <div id="info" style="
		          float:left;
		          width: 70%;
		          height: 100%;
		          padding:10px;
		          ">
		
		    	  	  <h2><%=requestedUser.getName()+" "+requestedUser.getLastName() %></h2>
		    	  	  <%
		    	  	  if(isMe){ %>
		    	  		 <a href="myprofile.jsp">Editar</a> 
		    	  <%  }
		    	  	  %>
			          <p>Alias: <%=requestedUser.getUserName() %></p>
			          <p>Fecha de nacimiento: <%=dh.getHTMLDate(requestedUser.getBirthday()) %></p>
			          <p>Email: <%=requestedUser.getEmail() %></p>
		
		        </div>  
	      </div>
	      
<%if(requestedUser.isClient()){ %>	      
    <!-- BIBLIOTECA -->   
       <!-- Page Heading -->
      <h1 class="my-4">Biblioteca
        <small></small>
      </h1>
        
	<%
	if(toShow){
		for(Play p : playList){%>
	      <!-- Play -->
	      <div class="row">
	        <div class="col-md-7">
	          <a href="#">
	            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=p.imageSRC() %>" alt="">
	          </a>
	        </div>
	        <div class="col-md-5">
	          <h3><a href="viewplay?id=<%=p.getId() %>"><%=p.getName() %></a> </h3>
	          <p><%=p.getDescription() %></p>
	          <%if(isMe){ %>
	          <a class="btn btn-secondary" href="removefromlibrary?playId=<%=p.getId() %>&returnToViewUser=true">Quitar</a>
	          <%} %>
	        </div>
	      </div>
	      <hr> <!-- Esta linea divide las obras -->		
	<%	}
	}
	else{
		if(!isMe){
	%>
		<p>No hay obras en la biblioteca del usuario</p>
	<%
		}
		else{%>
		<p>Aun no has agregado obras a tu biblioteca. Te invitamos a que lo hagas desde nuestra <a href="home">cartelera</a> o bien desde nuestro <a href="search.jsp">buscador</a> </p>	
<%		}
	}
}	
%>  

<!-- COMENTARIOS -->
       <!-- Page Heading -->
      <h1 class="my-4">Comentarios
        <small></small>
      </h1>



<%
	
if(!comments.isEmpty()){ %>
	<!-- comments container -->
	<div class="comment_block">
<%	
	Set<Integer> ids = comments.keySet();
	for(int parentId : ids){
		Comment parent = comments.get(parentId); 
		
		if(parent.hasChildren()){ %>
		  	<small><%=requestedUser.getUserName()%> ha respondido a un comentario en la obra <a href="viewplay?id=<%=parent.getPlayId() %>"><%=parent.getPlayName() %></a> </small>	
<%		}
		else{ %>
			<small><%=requestedUser.getUserName()%> ha comentado en <a href="viewplay?id=<%=parent.getPlayId() %>"><%=parent.getPlayName() %></a> </small>	
<%		}
 %>

		 <!-- new comment -->
		 <div class="new_comment">

			<!-- build comment -->
		 	<ul class="user_comment">

		 		<!-- current user avatar -->
			 	<div class="user_avatar">
			 		<a href="viewuser?requestedUserId=<%=parent.getUserId() %>" class="nostyle"><img src="<%=parent.imageSRC() %>"></a>
			 	</div><!-- the comment body --><div class="comment_body">
			 		<p><%=parent.getText() %></p>
			 	</div>

			 	<!-- comments toolbar -->
			 	<div class="comment_toolbar">

			 		<!-- inc. date and time -->
			 		<div class="comment_details">
			 			<ul>
			 				<li><i class="fa fa-clock-o"></i> <%=dh.getHTMLTime(parent.getDate()) %></li>
			 				<li><i class="fa fa-calendar"></i> <%=dh.getHTMLDate(parent.getDate()) %></li>
			 				<li><i class="fa fa-pencil"></i> <a href="viewuser?requestedUserId=<%=parent.getUserId() %>" class="nostyle"><span class="user"><%=parent.getUserName() %></span></a></li>
			 			</ul>
			 		</div>

			 	</div> <!-- FINISH comments toolbar -->
			
	<% 
		if(parent.hasChildren()){
			ArrayList<Comment> children = parent.getChildren();
			for(Comment child : children){ 
	%>
			 	<!-- CHILDREN (Replies) -->
		 	<li>
		 		
		 		<!-- current user avatar -->
			 	<div class="user_avatar">
			 		<a href="viewuser?requestedUserId=<%=child.getUserId() %>" class="nostyle"><img src="<%=child.imageSRC() %>"></a>
			 	</div><!-- the comment body --><div class="comment_body">
			 		<p><div class="replied_to"><p><a href="viewuser?requestedUserId=<%=parent.getUserId() %>" class="nostyle"><span class="user"><%=parent.getUserName() %></span></a><%=parent.getText() %></p></div><%=child.getText() %></p>
			 	</div>

			 	<!-- comments toolbar -->
			 	<div class="comment_toolbar">

			 		<!-- inc. date and time -->
			 		<div class="comment_details">
			 			<ul>
			 				<li><i class="fa fa-clock-o"></i> <%=dh.getHTMLTime(child.getDate()) %></li>
			 				<li><i class="fa fa-calendar"></i> <%=dh.getHTMLDate(child.getDate()) %></li>
			 				<li><i class="fa fa-pencil"></i> <a href="viewuser?requestedUserId=<%=child.getUserId() %>" class="nostyle"><span class="user"><%=child.getUserName() %></span></a></li>
			 			</ul>
			 		</div>

			 	</div>
		 	</li> <!-- TERMINA EL CHILDREN -->
		 	
	<%		} //cierro el for each children
		} //cierro el if has children	
	%>	 	
		 	</ul>
		 </div> <!-- ACA TERMINA EL COMMENT THREAD -->
		 
<%	} //cierro el for each parent %>
	</div><!-- comments container -->
<%} //cierro el if has parents
else{
	%>
		<p>El usuario no ha realizado comentarios aún</p>
	<%
	}
%>	
	
        
        
        
        
    </div> <!-- /.container -->
    
   
   

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
