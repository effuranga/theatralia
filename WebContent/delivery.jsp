<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.DTODeliveryTable"
    import="utils.Header"
    import="utils.DateHandler"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || loggedUser.isClient()){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}

ArrayList<DTODeliveryTable> rows = (ArrayList<DTODeliveryTable>) request.getAttribute("rows");
DateHandler dh = new DateHandler();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Delivery</title>

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

    <%=Header.getHeader(loggedUser, "tickets") %>

    <!-- Page Content -->
    
        <div id="wrapper">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Tickets Delivery <br>
              <small>(*) Solo se muestran los tickets del día de hoy o futuros</small>
              <%if(loggedUser.isAdmin()){ %>
              <br><a class="btn btn-primary" href="expiredtickets">Tickets vencidos</a>
              <br><a href="delivery?export=true" target="_blank"><img src="utils/excel.png" width="40px" height="40px" /> </a>
              <%} %>
			</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Ticket Id</th>
                      <th>Obra</th>
                      <th>Función</th>
                      <th>Cliente</th>
                      <th>Tarjeta</th>
                      <th>Pago</th>
                      <th>Delivery code</th>
                      <th>Fecha de compra</th>
                      <th>Cobro</th>
                      <th>Entrega</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Ticket Id</th>
                      <th>Obra</th>
                      <th>Función</th>
                      <th>Cliente</th>
                      <th>Tarjeta</th>
                      <th>Pago</th>
                      <th>Delivery code</th>
                      <th>Fecha de compra</th>
                      <th>Cobro</th>
                      <th>Entrega</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%				if(rows.isEmpty()){%> 
				 <tr>
				 <td>No hay tickets pendientes de entrega</td>
				 </tr>
<%				}
				else{
					for(DTODeliveryTable dto : rows){
	%>                  
	                    <tr>
	                      <td><a href="previewticket?ticketId=<%=dto.getTicketId() %>" target="_blank"><%=dto.getTicketId() %></a></td>
	                      <td><%=dto.getPlayName() %></td>
	                      <td><%=dh.getHTMLDate(dto.getShowDate())+" "+dh.getHTMLTime(dto.getShowDate()) %></td>
	                      <td><%=dto.getUserLastName()+", "+dto.getUserName() %></td>
	                      <td><%=dto.getCardNumber() %></td>
	                      <td><%=(dto.isPaid())? "Si" : "No" %></td>
	                      <td><%=dto.getDeliveryCode() %></td>
	                      <td><%=dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate()) %></td>
	                      <td><a href="payticket?ticketId=<%=dto.getTicketId() %>" onclick="return confirm('Esta a punto de facturar el ticket.');" <%=(dto.isPaid())? "style=\"pointer-events: none; cursor: default; color: grey\"" : ""%>>Cobrar</a></td>
	                      <td><a href="changeticketstatus?ticketId=<%=dto.getTicketId() %>" onclick="return confirm('A continuacion se imprimirá el ticket y se lo considerará entregado.');" <%=(dto.isPaid())? "" : "style=\"pointer-events: none; cursor: default; color: grey;\""%>>Entregar</a></td>               			
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
    
    <!-- Mensajes de alerta -->
    <%
    String action = request.getParameter("action");
    boolean pop = (action != null)? true : false;
    String message = "";
    if(pop){
	    switch(action){
	    	case "pay":
	    		message = "Se registró el cobro correctamente";
	    		break;
	    	case "delivery":
	    		message = "Se registró la entrega correctamente";
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