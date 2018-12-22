<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="business.Card"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
ArrayList<Card> cards = (ArrayList<Card>) request.getAttribute("cards");

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>My cards</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">
    
    <!-- Recursos para las tablas>
    <link href="tableFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="tableFE/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="tableFE/vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="tableFE/css/sb-admin.css" rel="stylesheet">

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
          <img src="utils/cc.gif" width="300px" height="300px">
          

        </div>
        <div id="info" style="
          float:left;
          width: 70%;
          height: 100%;
          padding:10px;
          ">
         <h2>Mis tarjetas</h2>
	 	 
<%      //Añado nueva tarjeta	
		if(request.getParameter("add") != null && request.getParameter("add").equals("true")){
%>			
	    <form action="newcard" method="POST" >
	    <select name="type">
		  <option value="Visa">Visa</option>
		  <option value="Mastercard">Mastercard</option>
		  <option value="American Express">American Express</option>
		</select>		
	    <label>Número: <input type="number" name="number" required/></label><br/>
	    <input type="text" name="name" placeholder="Nombre que figura en la tarjeta" size="50" required/><br />
	    <input type="text" name="description" placeholder="Descripción (opcional)" /><br />
	    <label>Vmto: <input type="number" placeholder="mm" name="exp_month" min="1" max="12" required><br></label><small>/</small>
	    <input type="number" placeholder="aa" name="exp_year" min="18" max="30" required><br/>
	    <input type="submit" class="btn btn-primary" value="Guardar"/>
	    <a href="mycards" class="btn btn-secondary">Cancelar</a>
	    </form>		
<%		}
		else{
	         if(cards == null || cards.isEmpty()){
	        	 out.print(printMessage(request));
	%>
	
			<p> Aún no has cargado ninguna tarjeta de crédito o débito </p> <br>
			<a href="mycards?add=true" class="btn btn-primary">Nueva tarjeta</a> 	
	<%        	 
	         }
	         else{
	        	
	%>      	 
	  	<div id="wrapper">
	      <div id="content-wrapper">
	        <div class="container-fluid">

	          <!-- DataTables Example -->
	          <div class="card mb-3">
	            <div class="card-header">
	              <i class="fas fa-table"></i>
	              <a href="mycards?add=true" class="btn btn-primary">(+) Nueva tarjeta</a> </div>
	            <div class="card-body">
	              <div class="table-responsive">
	                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
	                  <thead>
	                    <tr>
	                      <th>Tarjeta</th>
	                      <th>Numero</th>
	                      <th>Descripción</th>
	                      <th>Acciones</th>
	                    </tr>
	                  </thead>
	                  <tbody>
	                  
					<% for(Card c : cards){                  
	%>                   <tr>
	                      <td><%=c.getType() %></td>
	                      <td><%=c.getNumber() %></td>
	                      <td><%if(c.getDescription() != null) out.print(c.getDescription()); %></td>
	                       <td>
	                       <a href="deletecard?id=<%=c.getId() %>" onclick="return confirm('¿Está seguro que desea eliminar esta tarjeta?');">Eliminar</a>
	                      </td>
	                    </tr>
					<%} %>                                       
	                  </tbody>
	                </table>
	              </div>
	            </div>
	            	<div class="card-footer small text-muted">
					<%=printMessage(request) %>
					</div>
	          </div>
	        </div>
	        <!-- /.container-fluid -->
	      </div>
	      <!-- /.content-wrapper -->
	    </div>
	    <!-- /#wrapper -->  	
			
			
<%			}			

		}
%>     
        </div>      
    </div>
    <!-- /.container -->



    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Recursos para las tablas-->
    <script src="tableFE/vendor/jquery/jquery.min.js"></script>
    <script src="tableFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="tableFE/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="tableFE/vendor/datatables/jquery.dataTables.js"></script>
    <script src="tableFE/vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="tableFE/js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="tableFE/js/demo/datatables-demo.js"></script>
  </body>

</html>

<%!
private String printMessage(HttpServletRequest request){	
	if(request.getParameter("message")!= null){
		if(request.getParameter("message").equals("Su tarjeta se ha cargado con exito")){
			  return "<small style=\"color: green;\">(*)"+request.getParameter("message")+"</small>";
		}
		if(request.getParameter("message").equals("La tarjeta se ha eliminado correctamente")){
			  return "<small style=\"color: green;\">(*)"+request.getParameter("message")+"</small>";
		}
		else{
			return "<small style=\"color: red;\">(*)"+request.getParameter("message")+"</small>";
		}
	}
	return "";
}
%>
