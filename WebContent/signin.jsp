<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
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

    <section id="contact">
      <div class="container">
        <div class="row">
          <div class="col-lg-8 mx-auto text-center">
            <h2 class="section-heading">¡Regístrate en Theatralia®!</h2>
            <hr class="my-4">
            <p class="mb-5">Formulario de registro</p>
            <form action="signin" method="POST">
              <input type="text" placeholder="User name" name="userName" <%if(fail){ %>value="<%=request.getParameter("userName") %>" <%} %>/> <br/>
              <input type="password" placeholder="Password" name="password" /><br/>
              <input type="password" placeholder="Repeat password" name="repPassword" /><br/>
              <input type="text" placeholder="Name" name="name" <%if(fail){ %>value="<%=request.getParameter("name") %>" <%} %>/><br/>
              <input type="text" placeholder="Last name" name="lastName" <%if(fail){ %>value="<%=request.getParameter("lastName") %>" <%} %>/><br/>
              <input type="date" name="birthday" /><br/>
              <input type="text" name="email" placeholder="email" <%if(fail){ %>value="<%=request.getParameter("email") %>" <%} %>/><br/>
              <br/>
              <input type="submit"class="btn btn-primary btn-xl" value="¡Regístrate!"/><br/>
              <p> </p>
              <a class="btn btn-secondary btn-xl sr-button" href="#">Volver</a>
            </form>  
            <%
if(fail){
	for(String s: errorsList){
		out.println(s);
	}
}
%>    
          </div>
        </div>
        <div class="row">
          <div class="col-lg-4 ml-auto text-center">
            <i class="fas fa-phone fa-3x mb-3 sr-contact-1"></i>
            <p>123-456-6789</p>
          </div>
          <div class="col-lg-4 mr-auto text-center">
            <i class="fas fa-envelope fa-3x mb-3 sr-contact-2"></i>
            <p>
              <a href="mailto:your-email@your-domain.com">contato@theatraliaplatform.com</a>
            </p>
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

  </body>

</html>


