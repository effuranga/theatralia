<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.ArrayList"
    import="business.Card"
    import="business.Play"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null || !loggedUser.isAdmin()){
	response.sendRedirect("error.jsp?e=No tengo el usuario en la session");
	return;
}
ArrayList<Play> plays = (ArrayList<Play>) request.getAttribute("allPlays");

%>
<!DOCTYPE html>
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Admin Plays</title>

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
    
        <div id="wrapper">
      <div id="content-wrapper">

        <div class="container-fluid">
          <!-- DataTables Example -->
          <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Administrar obras</div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Obra</th>
                      <th>Visible</th>
                      <th>Estrella</th>
                      <th>Shows</th>
                      <th>Editar</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Obra</th>
                      <th>Visible</th>
                      <th>Estrella</th>
                      <th>Shows</th>
                      <th>Editar</th>
                    </tr>
                  </tfoot>
                  <tbody>
<%
				for(Play p : plays){
%>                  
                    <tr>
                      <td><%=p.getName() %></td>
                      <% 
                      String action = "changeplayvisibility?playId="+p.getId()+"&toStatus=";
                      String text ="";
                      if(p.getStatus() == 1) {
                    	  text = "Si";
                    	  action += 0;
                      	} 
                      else {
                    	  text = "No";
                    	  action += 1;
                      	}                    
                      %>
                      <td><a href="<%=action %>"><%=text %></a></td>
                      <td><% if(p.getStarred() == 1) out.print("Si"); else out.print("No");%></td>
                      <td><a href="viewshows?playid=<%=p.getId() %>">Ver shows</a></td>
                      <td><a href="editplay?playid=<%=p.getId() %>">Editar</a></td>
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