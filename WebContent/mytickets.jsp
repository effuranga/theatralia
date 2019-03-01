<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.Header"
    import="utils.DTOMyTickets"
    import="utils.DateHandler"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isClient()){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
ArrayList<DTOMyTickets> dtoMyTicketsList = (ArrayList<DTOMyTickets>) request.getAttribute("dto");
DateHandler dh = new DateHandler();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Mis tickets</title>

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

    <%=Header.getHeader(loggedUser, "profile") %>

    <!-- Page Content -->
    
        <div id="wrapper">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Mis tickets </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>Obra</th>
                      <th>Funcion</th>
                      <th>Entregado</th>
                      <th>Pagado</th>
                      <th>Delivery code</th>
                      <th>Tarjeta</th>
                      <th>Fecha de compra</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Id</th>
                      <th>Obra</th>
                      <th>Funcion</th>
                      <th>Entregado</th>
                      <th>Pagado</th>
                      <th>Delivery code</th>
                      <th>Tarjeta</th>
                      <th>Fecha de compra</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%
				for(DTOMyTickets d : dtoMyTicketsList){
%>                  
                    <tr>
                      <td><a href="previewticket?ticketId=<%=d.getTicketId() %>"><%=d.getTicketId() %></a></td>
                      <td><a href="#=<%=d.getPlayId() %>"><%=d.getPlayName() %></a></td>
                      <td><%=dh.getHTMLDateAndTime(d.getShowDate()) %></td>
                      <td><%=(d.isDelivered())? "Si" : "No" %></td>
                      <td><%=(d.isPaid())? "Si" : "No" %></td>
                      <td><%=d.getDeliveryCode() %></td>
                      <td><%=d.getCardNumber() %></td>
                      <td><%=dh.getHTMLDateAndTime(d.getBuyingDate()) %></td>
                    </tr>
<%
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