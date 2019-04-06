<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.DTODeliveryTable"
    import="utils.Header"
    import="utils.DateHandler"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isAdmin()){
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
              Tickets expirados <br>
              <small>(*) Solo se muestran los tickets de fechas pasadas que no fueron entregados (pagados o morosos)</small>
              <%if(loggedUser.isAdmin()){ %>
              <br><a class="btn btn-primary" href="delivery">Atras</a> 
              		<%if(isAnyPaidPending(rows)) { %>
		              <a class="btn btn-primary" href="chargeallcards" style="background-color: #ff3333; border-color: #ff3333;"
		              onclick="return confirm('Esta a punto de realizar una transacción bancaria masiva a todas las tarjetas morosas. ¿Está seguro que desea continuar?');"
		              >(!) Cargar todos</a>
              <%	}
              } %>
              <br><a href="expiredtickets?export=true" target="_blank"><img src="utils/excel.png" width="40px" height="40px" /> </a>
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
                      <th>Pago</th>
                      <th>Fecha de compra</th>
                      <th>Tarjeta</th>
                      <th>Cargar a tarjeta</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Ticket Id</th>
                      <th>Obra</th>
                      <th>Función</th>
                      <th>Cliente</th>             
                      <th>Pago</th>
                      <th>Fecha de compra</th>
                      <th>Tarjeta</th>
                      <th>Cargar a tarjeta</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%				if(rows.isEmpty()){%> 
				 <tr>
				 <td>No hay tickets vencidos</td>
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
	                      <td><%=(dto.isPaid())? "Si" : "No" %></td>
	                      <td><%=dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate()) %></td>
	                      <td><%=dto.getCardNumber() %></td>
	                      <td><a href="chargeincard?ticketId=<%=dto.getTicketId() %>" onclick="return confirm('ATENCION. Esta a punto de cargar facturación a la tarjeta del cliente. Este proceso incurrirá en acciones bancarias y no se podrá deshacer.');" <%=(dto.isPaid())? "style=\"pointer-events: none; cursor: default; color: grey\"" : ""%>>Cargar</a></td>                         			
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
	    	case "singlecharge":
	    		message = "Se cargó el monto a la tarjeta correctamente";
	    		break;
	    	case "batchcharge":
	    		message = "Todos los montos se han cargado satisfactoriamente";
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

<%! 
boolean isAnyPaidPending(ArrayList<DTODeliveryTable> rows){
	for(DTODeliveryTable r : rows){
		if(!r.isPaid()){
			return true;
		}
	}
	return false;
}
%>