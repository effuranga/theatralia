<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.DTOTicketList"
    import="utils.Header"
    import="utils.DateHandler"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}

ArrayList<DTOTicketList> rows = (ArrayList<DTOTicketList>) request.getAttribute("ticketslist");
DateHandler dh = new DateHandler();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Lista por funcion</title>

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
              <%=rows.get(0).getPlayName() %> <br>
              <small><%=dh.getHTMLDateAndTime(rows.get(0).getShowDate()) %></small>
              <br><a class="btn btn-primary" href="#">EXPORT</a>
			</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Ticket Id</th>
                      <th>Cliente</th>
                      <th>Vendedor</th>
                      <th>Tarjeta</th>
                      <th>Pago</th>
                      <th>Delivery code</th>
                      <th>Fecha de compra</th>
                      <th>Cant asientos</th>
                      <th>Total</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Ticket Id</th>
                      <th>Cliente</th>
                      <th>Vendedor</th>
                      <th>Tarjeta</th>
                      <th>Pago</th>
                      <th>Delivery code</th>
                      <th>Fecha de compra</th>
                      <th>Cant asientos</th>
                      <th>Total</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%				if(rows.isEmpty()){%> 
				 <tr>
				 <td>No hay tickets pendientes de entrega</td>
				 </tr>
<%				}
				else{
					for(DTOTicketList dto : rows){
	%>                  
	                    <tr>
	                      <td><a href="previewticket<%=(!dto.isClient())? "ocasional" : "" %>?ticketId=<%=dto.getTicketId() %>" target="_blank"><%=dto.getTicketId() %></a></td>
	                      <td><%=(dto.isClient())? dto.getUserLastName()+", "+dto.getUserName() : "CLIENTE OCASIONAL" %></td>
	                      <td><%=(dto.isClient())? "WEB" : dto.getUserLastName()+", "+dto.getUserName() %></td>
	                      <td><%=(dto.isClient())? dto.getCardNumber() : "N/A" %></td>
	                      <td><%=(dto.isPaid())? "Si" : "No" %></td>
	                      <td><%=(dto.isClient())? dto.getDeliveryCode() : "N/A" %></td>
	                      <td><%=dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate()) %></td>  
	                      <td><%=dto.getCantSeats() %></td>   
	                      <td><%="$ "+dto.getTotal() %></td>   			
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