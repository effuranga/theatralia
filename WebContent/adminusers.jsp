<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="utils.Header"
    import="utils.DateHandler"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
ArrayList<User> allUsers = (ArrayList<User>) request.getAttribute("allUsers");
DateHandler dh = new DateHandler();

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Users</title>

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

    <%=Header.getHeader(loggedUser, "adminusers") %>

    <!-- Page Content -->
    
        <div id="wrapper">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Administrar usuarios <br> <a href="createuser.jsp">(+) Nuevo usuario</a></div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>User Name</th>
                      <th>Apellido, Nombre</th>
                      <th>Email</th>
                      <th>Status</th>
                      <th>Rol</th>
                      <th>Alta</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Id</th>
                      <th>User Name</th>
                      <th>Apellido, Nombre</th>
                      <th>Email</th>
                      <th>Status</th>
                      <th>Rol</th>
                      <th>Alta</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%
				for(User u : allUsers){
%>                  
                    <tr>
                      <td><%=u.getUserId() %></td>
                      <td><%=u.getUserName() %></td>
                      <td><%=u.getLastName()+", "+u.getName() %></td>
                      <td><%=u.getEmail() %></td>
                      <td>
                      <%
                      String selectedInactive = (u.getStatus() == 0)? "selected" : "";
                      String selectedActive = (u.getStatus() == 1)? "selected" : "";
                      String selectedPending = (u.getStatus() == 2)? "selected" : "";
                      String disable = (u.getUserId() == loggedUser.getUserId())? "disabled" : "";
                      
                      String action = "changeuserstatus?userId="+u.getUserId()+"&toStatus=";
                      %>
	                     <select onchange="location = this.value;" <%=disable %>>
	                      <option value="<%=action+0 %>" <%=selectedInactive %>>Desactivado</option>
	                      <option value="<%=action+1 %>" <%=selectedActive %>>Activo</option>
	                      <option value="<%=action+2 %>" <%=selectedPending %>>Pendiente</option>
	                     </select>      
					 </td>
                      <td>
                      <%
                      String selectedClient = (u.isClient())? "selected" : "";
                      String selectedEmployee = (u.isEmployee())? "selected" : "";
                      String selectedAdmin = (u.isAdmin())? "selected" : "";
                      
                      String redir = "changeuserrole?userId="+u.getUserId()+"&toRole=";
                      %>
	                     <select onchange="location = this.value;" <%=disable %>>
	                      <option value="<%=redir+1 %>" <%=selectedClient %>>Cliente</option>
	                      <option value="<%=redir+2 %>" <%=selectedEmployee %>>Vendedor</option>
	                      <option value="<%=redir+3 %>" <%=selectedAdmin %>>Administrador</option>
	                     </select>  
					 </td>
                      <td><%=dh.getHTMLDate(u.getCreated())+" "+dh.getHTMLTime(u.getCreated()) %></td>
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
    
    <!-- Mensajes de alerta -->
    <%
    String action = request.getParameter("action");
    boolean pop = (action != null)? true : false;
    String message = "";
    if(pop){
	    switch(action){
	    	case "role":
	    		message = "El rol se actualizó correctamente";
	    		break;
	    	case "status":
	    		message = "El status se actualizó correctamente";
	    		break;	
	    	case "newUser":	
	    		message = "El usuario se creó correctamente";
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