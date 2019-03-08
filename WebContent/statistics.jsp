<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.DTOStatistics"
    import="utils.Header"
    import="utils.DateHandler"
    import="business.User"
    import="business.Play"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=El usuario debe ser administrador");
	return;
}

ArrayList<DTOStatistics> stats = (ArrayList<DTOStatistics>) request.getAttribute("stats");
DateHandler dh = new DateHandler();
Play play = (Play)request.getAttribute("play");

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Estadisticas</title>

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

  </head>

  <body id="page-top">

    <%=Header.getHeader(loggedUser, "adminplays") %>

    <!-- Page Content -->
        <div id="wrapper">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              <%=play.getName() %> <br>
              <small>Estadisticas</small>
              <br><a class="btn btn-primary" href="#">EXPORT</a>
			</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Show Id</th>
                      <th>Funcion</th>
                      <th>Entrada $</th>
                      <th>Asientos disp.</th>
                      <th>Recaudado</th>
                      <th>T. emitidos</th>
                      <th>T. facturados</th>
                      <th>Lista de tickets</th>
                      <th>Ver sala</th>
                    </tr>
                  </thead>
                  <tbody>
<%				if(stats.isEmpty()){%> 
				 <tr>
				 <td>Cuando existan funciones para la obra actual, las estadisticas apareceran aqui</td>
				 </tr>
<%				}
				else{
					for(DTOStatistics dto : stats){
	%>                  
	                    <tr>
		                  <td><%=dto.getShowId() %></td>
	                      <td><%=dh.getHTMLDateAndTime(dto.getShowDate()) %></td>
	                      <td><%="$ "+dto.getPrice() %></td>
	                      <td><%=dto.getAvailableSeats() %></td>
	                      <td><%="$ "+((98-dto.getAvailableSeats())*dto.getPrice()) %></td>
	                      <td><%=dto.getCantIssuedTickets() %></td>
	                      <td><%=(dto.getCantIssuedTickets() == 0)? 0+"%" : dto.getCantChargedTickets()*100/dto.getCantIssuedTickets()+"% || ("+dto.getCantChargedTickets()+")" %></td>
	                      <td><a href="listtickets?showId=<%=dto.getShowId() %>" <%if(dto.getCantIssuedTickets() == 0) out.print("style=\"pointer-events: none; cursor: default; color: grey\""); %>>Ver lista</a></td>
	                      <td><a target="_blank" href="viewchart?showId=<%=dto.getShowId() %>">Ver sala</a></td>                    
	                    </tr>
	<%
					}
				}
%>                       
                  </tbody>
                </table>
              </div>
            </div>
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
          </div>

        </div>
        <!-- /.container-fluid -->

      </div>
      <!-- /.content-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
      <i class="fas fa-angle-up"></i>
    </a>
    
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
   
  </body>

</html>