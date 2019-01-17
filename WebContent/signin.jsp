<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="java.util.Date"
    import="java.text.SimpleDateFormat"
    import="utils.DateHandler"
    import="business.User"%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Registro</title>

    <!-- Bootstrap core CSS -->
    <link href="homeFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="homeFE/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>

    <!-- Plugin CSS -->
    <link href="homeFE/vendor/magnific-popup/magnific-popup.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="homeFE/css/creative.min.css" rel="stylesheet">
    
    <!-- My CSS-->
    <link href="myCSS/myCSS.css" rel="stylesheet">

	<style>
		  body  {
		  background-image: url("homeFE/img/header.jpg");
		   /* Full height */
		  height: 100%; 
		
		  /* Center and scale the image nicely */
		
		  background-repeat: no-repeat;
		  background-size: cover;
	      background-attachment: fixed;
		}
	  </style>
  </head>

<%
	ArrayList<String> errorsList = (ArrayList<String>)request.getAttribute("errorsList");
	boolean fail;
	if(errorsList == null){
		fail = false;
	}
	else{
		fail = (errorsList.isEmpty())? false : true;
	}
%>
  <body id="page-top">

    <section id="contact" style="padding-top:3rem; padding-bottom:3rem;">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto text-center">
            <h2 class="section-heading" style="color:white;">¡Regístrate en Theatralia®!</h2>
            <hr class="my-4">
            <form action="signin" method="POST">
              <input type="text" placeholder="User name" name="userName" maxlength="15" <%if(fail){ %>value="<%=request.getParameter("userName") %>" <%} %> class="round" required/> <br/>
              <input type="password" placeholder="Password" name="password" class="round" maxlength="30" required /><br/>
              <input type="password" placeholder="Repeat password" name="repPassword" class="round" maxlength="30" required /><br/>
              <input type="text" placeholder="Name" name="name" <%if(fail){ %>value="<%=request.getParameter("name") %>" <%} %> class="round" maxlength="30" required/><br/>
              <input type="text" placeholder="Last name" name="lastName" <%if(fail){ %>value="<%=request.getParameter("lastName") %>" <%} %> class="round" maxlength="30" required/><br/>
                <%
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                int year = new Date().getYear();
                year -= 18;
                Date date = new Date();
                date.setYear(year);
	    		String now = format.format(date);
	            
	            %>
              <input type="date" name="birthday" max="<%=now %>" <%if(fail){ %>value="<%=request.getParameter("birthday") %>" <%} %> class="round" required/><br/>
              <input type="text" name="email" placeholder="email" <%if(fail){ %>value="<%=request.getParameter("email") %>" <%} %> class="round" maxlength="30" required/><br/>
              <br/>
              <input type="submit"class="btn btn-primary btn-xl" value="¡Regístrate!"/><br/>
              <p> </p>
              <a class="btn btn-secondary btn-xl sr-button" href="home">Volver</a>
            </form>  
            <%
if(fail){
	for(String s: errorsList){%>    
		<p style="color:white;"><%="(*) "+s %> </p>
<%	}
}
%>    
          </div>
        </div>
        
      </div>
    </section>

    <!-- Bootstrap core JavaScript -->
    <script src="homeFE/vendor/jquery/jquery.min.js"></script>
    <script src="homeFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="homeFE/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="homeFE/vendor/scrollreveal/scrollreveal.min.js"></script>
    <script src="homeFE/vendor/magnific-popup/jquery.magnific-popup.min.js"></script>

    <!-- Custom scripts for this template -->
    <script src="homeFE/js/creative.min.js"></script>
	
	<script>
	(function(window, location) {
	    history.replaceState(null, document.title, location.pathname+"#!/stealingyourhistory");
	    history.pushState(null, document.title, location.pathname);
	
	    window.addEventListener("popstate", function() {
	      if(location.hash === "#!/stealingyourhistory") {
	            history.replaceState(null, document.title, location.pathname);
	            setTimeout(function(){
	              location.replace("home");
	            },0);
	      }
	    }, false);
	}(window, location));
	</script>

  </body>

</html>


