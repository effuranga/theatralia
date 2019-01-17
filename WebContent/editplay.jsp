<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Date"
    import="java.text.SimpleDateFormat"
    import="utils.DateHandler"
    import="business.Play"
    import="business.Show"
    import="utils.Header"
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
    
	<!-- Recursos para las tablas>
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

    <!-- Page level plugin CSS-->
    <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin.css" rel="stylesheet">
    
    <!-- My CSS-->
    <link href="myCSS/myCSS.css" rel="stylesheet">
    
    <!--File button-->
    <link rel="stylesheet" type="text/css" href="fileButton/component.css" />
	<script>(function(e,t,n){var r=e.querySelectorAll("html")[0];r.className=r.className.replace(/(^|\s)no-js(\s|$)/,"$1js$2")})(document,window,0);</script>
	
  </head>

  <body>

    <%=Header.getHeader(user, "adminplays") %>
	
    <!-- Page Content -->
    <div class="container" >
    
    	<!-- Page Heading -->
      <h1 class="my-4">Editar
        <small><%=play.getName() %></small>
      </h1>
      
        <div id="image" style="
          float:left;
          height: 100%;

        ">

          <img class="img-fluid rounded mb-3 mb-md-0" style="height: 300px; width: 600px" src="<%=play.imageSRC() %>" alt="">
          
        </div>
        <div id="info" style="
          float:left;
          width: 30%;
          height: 100%;
          padding:10px;
          ">

          	<form action="updateplay?id=<%=play.getId() %>" id="form" method="POST" enctype="multipart/form-data">
				<input type="text" name="name" placeholder="Name of the play" value="<%=play.getName() %>" class="round" maxlength="30" required /><br/>
				<input type="text" name="author" placeholder="Author of the play" value="<%=play.getAuthor() %>" class="round" maxlength="30" required /><br/>
				<textarea maxlength="500" rows="4" cols="50" form="form" name="description" placeholder="Description of the play" required><%=play.getDescription() %></textarea><br/>
				
				<div class="box">
					<input type="file" accept="image/jpeg" name="uploadFile" id="uploadFile" class="inputfile inputfile-1" data-multiple-caption="{count} files selected" style="display:none;" multiple />
					<label for="uploadFile"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="17" viewBox="0 0 20 17"><path d="M10 0l-5.2 4.9h3.3v5.1h3.8v-5.1h3.3l-5.2-4.9zm9.3 11.5l-3.2-2.1h-2l3.4 2.6h-3.5c-.1 0-.2.1-.2.1l-.8 2.3h-6l-.8-2.2c-.1-.1-.1-.2-.2-.2h-3.6l3.4-2.6h-2l-3.2 2.1c-.4.3-.7 1-.6 1.5l.6 3.1c.1.5.7.9 1.2.9h16.3c.6 0 1.1-.4 1.3-.9l.6-3.1c.1-.5-.2-1.2-.7-1.5z"/></svg> <span>Cargar imagen&hellip;</span></label>
				</div>

	          <input type="submit" class="btn btn-primary" value="Editar"/>
	          <a href="adminplays" class="btn btn-secondary">Cancelar</a><br>
	          
	        </form>
        
        	
        
        
        </div>      
        
        <%
        ArrayList<Show> shows = play.getShows();
        %>
   
   <!-- Tabla de shows -->     
   
    <div id="wrapper" class="container">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Funciones</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Fecha</th>
                      <th>Estado</th>
                      <th>Asientos disponibles</th>
                    </tr>
                  </thead>
                  <tbody>
<%				DateHandler dh = new DateHandler();
				for(Show s : shows){
%>                  
                    <tr>
                      <td><%=s.getId() %></td>
                      <td><%=dh.getHTMLDate(s.getDate())+" "+dh.getHTMLTime(s.getDate()) %></td>
                      <%String status; 
                      boolean showAmounOfSeats = false;
                      String color = "";
                      if(s.isAFutureShow()){
                    	  if(s.hasSeatsAvailable()){
                    		  status = "Disponible";	
                    		  color = "style=\"color: rgb(51, 204, 51); font-weight: bold;\""; //verde
                    	  }
                    	  else{
                    		  status = "Completo";
                    		  color = "style=\"color: rgb(179, 0, 0);\""; //bordo
                    	  }
                    	  showAmounOfSeats = true;
                      }
                      else{
                    	  status = "Finalizado";
                    	  color = "style=\"color: rgb(89, 89, 89);\""; //gris
                      }
                      
                      %>
                      <td <%=color %>><%=status %></td>
                      <td <%=color %>><%if(showAmounOfSeats) out.print(s.countSeatsAvailable()); else out.print("-"); %></td>
                    </tr>
<%
				}
				if(shows.isEmpty()){%> 
					<tr>
						<td>No hay funciones para esta obra.</td>
					</tr>
<%				}
%>                       
                  </tbody>
                </table>
              </div>
            </div>
            <%
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
    		String now = format.format(new Date());
            
            %>
            <div class="card-footer small text-muted"><form action="createshow?id=<%=play.getId() %>" method="POST" >
        		<input type="datetime-local" name="showdate" min="<%=now %>" class="round" required> 
        		<input type="submit" class="btn btn-primary" onclick="return confirm('Si ha editado la obra y aún no ha hecho click en Editar, se perderán los cambios. ¿Está seguro que desea continuar?');" value="Nueva funcion" >
        	</form></div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->
   
        
    </div>
    <!-- /.container -->

    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Recursos para las tablas-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Page level plugin JavaScript-->
    <script src="vendor/datatables/jquery.dataTables.js"></script>
    <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin.min.js"></script>

    <!-- Demo scripts for this page-->
    <script src="js/demo/datatables-demo.js"></script>
   
    <!-- File button-->
    <script src="fileButton/custom-file-input.js"></script>
  </body>

</html>