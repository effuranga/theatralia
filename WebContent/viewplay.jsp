<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Show"
    import="business.Comment"
    import="java.util.Set"
    import="utils.DateHandler"
    import="utils.Header"
    import="business.User"%>
<%
// ACA YA ME LLEGA LA OBRA SIN SHOWS PASADOS, NI SHOWS QUE NO TENGAN ASIENTOS

Play play = (Play) request.getAttribute("play");
if(play == null){
	response.sendRedirect("error.jsp?e=La obra solicitada no existe");
	return;
}
boolean hasImage = false;
String noImage = "utils/noimage.jpg";

User loggedUser = (User) session.getAttribute("loggedUser");
HashMap<Integer, Comment> comments = (HashMap<Integer, Comment>) request.getAttribute("comments");

// Data por si tengo que vender
ArrayList<Show> shows = play.getShows();
if(!shows.isEmpty()) System.out.println("No esta vacio. Tiene shows");
%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Dashboard</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">

	<!-- Comment -->
    <link rel="stylesheet" href="commentFE/css/style.css">
    
    <!-- myCSS -->
    <link rel="stylesheet" href="myCSS/myCSS.css">
    
  </head>
		<style>
		a.replylink:link {
		    text-decoration: inherit;
		    color: orange;
		}
		
		a.replylink:visited {
		    text-decoration: inherit;
		    color: orange;
		}
		a.nostyle:link {
		    text-decoration: inherit;
		    color: inherit;
		}
		
		a.nostyle:visited {
		    text-decoration: inherit;
		    color: inherit;
		}
		</style>
  <body>
 
	<%=(play.getStatus() == 1)? Header.getHeader(loggedUser, "dashboard") : Header.getHeader(loggedUser, "searchplay") %>
    
    	<!-- Page Content -->
	    <div class="container">
	
	      <!-- Page Heading -->
	      <h1 class="my-4"><%=play.getName() %>
	        <small></small>
	      </h1>
	
	
	      <!-- Play -->
	      <div class="row">
	        <div class="col-md-7">
	          <a href="#">
	            <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=play.imageSRC() %>" alt="">
	          </a> 
	        </div>
	        <div class="col-md-5">
	          <h3><%=play.getName() %></h3>
	          <p><%=play.getDescription() %></p>
	<%		if(loggedUser.isClient()) {
	          if(play.getStatus()==1 && play.hasShowsInTheFuture() && play.oneShowInTheFutureHasAvailableSeats()) {%><a class="btn btn-primary" href="setpurchase?id=<%=play.getId() %>">Comprar</a> <%}%>    	 
	 <%			if(!(boolean) request.getAttribute("addedInLibrary")){ %>
		 			<a class="btn btn-primary" href="addtolibrary?playId=<%=play.getId() %>">(+)Biblioteca</a>
	<%			}
	 			else{%>
	 				<a class="btn btn-secondary" href="removefromlibrary?playId=<%=play.getId() %>">(-)Biblioteca</a>
	<%			}
			} 
			else{
		      	if(play.getStatus()==1 && play.hasShowsInTheFuture() && play.oneShowInTheFutureHasAvailableSeats()) {
		      		DateHandler dh = new DateHandler();
		      	%>             
		          <form action="sell" method="get">
		          	<select name="showId" class="round" required>
	<%  				for(Show s : shows){
							if(s.hasSeatsAvailable()){
	%>						<option value="<%=s.getId()%>"><%=dh.getHTMLDate(s.getDate())+" "+dh.getHTMLTime(s.getDate())%></option>
	<%        				}
						}%>          		
					</select>
					<input type="hidden" name="id" value="<%=play.getId() %>">
					<input type="submit" class="btn btn-primary" value="Vender" />	
		          </form>
	<% 			}
			}%>          
	        </div>
	      </div>
	      <hr name="bar" id="bar"> <!-- Esta linea divide las obras -->		
	      

<!-- comments container -->
	<div class="comment_block">

		 <!-- used by user to create a new comment -->
		 <div class="create_new_comment">

			<!-- current user avatar -->
		 	<div class="user_avatar">
		 		<img src="<%=loggedUser.imageSRC() %>">
		 	</div><!-- the input field --><div class="input_comment">
		 	<% 
		 	String pId = (String) request.getParameter("parentId");
		 	boolean isReply = (pId != null && !pId.trim().isEmpty())? true : false;
		 	String ph = (isReply)? "Contestále a "+comments.get(Integer.parseInt(pId)).getUserName() : "¡Comenta, no seas tímido!";

		 	%>
		 		<form name="loginBox" id="loginBox" method="get" action="createcomment">
					<input type="text" name="text" id="text" placeholder="<%=ph %>" maxlength="200" required <%if(isReply) out.print("autofocus"); %>>
					<input type="hidden" name="playId" value="<%=play.getId() %>" >
					<%
					if(isReply){
						%>
					<input type="hidden" name="parentId" value="<%=pId %>" >	
				<%	} %>
    				<input type="submit" style="display: none;" />
				</form>
		 	</div>

		 </div>
<%
	
if(!comments.isEmpty()){
	Set<Integer> ids = comments.keySet();
	DateHandler dh = new DateHandler();
	for(int parentId : ids){
		Comment parent = comments.get(parentId);

	
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
			 		</div><!-- inc. share/reply and love --><div class="comment_tools">
			 		<%
			 		int amountOfLikes = parent.amountOfLikes();
			 		boolean hasMyLike = parent.hasMyLike(loggedUser.getUserId());
			 		String amountHTML = "";
			 		if(amountOfLikes != 0){
			 			amountHTML = "<span class=\"love_amt\"> "+amountOfLikes+"</span>";
			 		}
			 		String noStyleClass = "";
			 		String coloured = "";
			 		String URLto = "like";
			 		if(!hasMyLike){
			 			noStyleClass = "class=\"nostyle\"";
			 		}
			 		else{
			 			coloured = "style=\"color: #FF6347;\"";
			 			URLto = "dislike";
			 		}
			 		%>
			 			<ul>
			 				<li><a href="viewplay?id=<%=play.getId() %>&parentId=<%=parent.getId() %>#bar" class="replylink"><i class="fa fa-reply"></i></a></li>
			 				<li><a href="<%=URLto %>?commentId=<%=parent.getId() %>&playId=<%=play.getId() %>" <%=noStyleClass %>><i class="fa fa-heart love" <%=coloured %>><%=amountHTML %></i></a></li>
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
			 		</div><!-- inc. share/reply and love --><div class="comment_tools">
			 			<ul>
			 			<%
				 		amountOfLikes = child.amountOfLikes();
				 		hasMyLike = child.hasMyLike(loggedUser.getUserId());
				 		amountHTML = "";
				 		if(amountOfLikes != 0){
				 			amountHTML = "<span class=\"love_amt\"> "+amountOfLikes+"</span>";
				 		}
				 		noStyleClass = "";
				 		coloured = "";
				 		URLto = "like";
				 		if(!hasMyLike){
				 			noStyleClass = "class=\"nostyle\"";
				 		}
				 		else{
				 			coloured = "style=\"color: #FF6347;\"";
				 			URLto = "dislike";
				 		}
				 		%>
			 				<li><a href="<%=URLto %>?commentId=<%=child.getId() %>&playId=<%=play.getId() %>" <%=noStyleClass %>><i class="fa fa-heart love" <%=coloured %>><%=amountHTML %></i></a></li>
			 			</ul>
			 		</div>

			 	</div>
		 	</li> <!-- TERMINA EL CHILDREN -->
		 	
	<%		} //cierro el for each children
		} //cierro el if has children	
	%>	 	
		 	</ul>
		 </div> <!-- ACA TERMINA EL COMMENT THREAD -->
		 
<%	} //cierro el for each parent
} //cierro el if has parents
%>	
		

	</div><!-- comments container -->
	
	    </div>
	    <!-- /.container -->

			

   

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
	    	case "newcommentsuccess":
	    		message = "¡Gracias por comentar!";
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
