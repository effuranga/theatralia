<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="utils.Header"
    import="business.Play"
    import="utils.DateHandler"
    import="utils.DTODescriptionExtension"
    import="business.User"%>
<%
User loggedUser = (User) session.getAttribute("loggedUser");
if(loggedUser == null){
	response.sendRedirect("error.jsp?e=Debe iniciar sesion para poder realizar esta accion");
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

    <title>FAQs</title>

    <!-- Bootstrap core CSS -->
    <link href="dashboardFE/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="dashboardFE/css/1-col-portfolio.css" rel="stylesheet">
	
	<!-- MyCss -->
    <link href="myCSS/myCSS.css" rel="stylesheet">
    
  </head>

  <body>

    <%=Header.getHeader(loggedUser, "faqs") %>

    <!-- Page Content -->
    <div class="container">

      <!-- Page Heading -->
      <h1 id="faqstop" class="my-4">Preguntas frecuentes / C�mo usar
        <small></small>
	  </h1>
	<%if(!loggedUser.isClient()){ %>
		<a href="faqs?to=c" style="color:#ff9955">Cliente / </a>
		<a href="faqs?to=e" style="color:#ff9955">Empleado / </a>
		<%if(loggedUser.isAdmin()){ %>
		<a href="faqs?to=a" style="pointer-events: none; cursor: default; color: grey;">Administrador</a>
	<%	}
	  }%>	
		<br/>
	<!-- Indice de preguntas -->	
		<div id="indexTable" class="indexTable" >
		<h2>�ndice</h2>
			<ol>
				<li><a href="#r1">�C�mo ingresar una nueva obra al sistema?</a></li>
				<li><a href="#q1">�Necesito cargar una imagen para cada obra?</a></li>
				<li><a href="#q2">Cuando doy de alta una obra, �aparecer� en cartelera autom�ticamente?</a></li>
				<li><a href="#q3">�C�mo administro la cartelera?</a></li>
				<li><a href="#q4">�C�mo edito una obra?</a></li>
				<li><a href="#q5">�C�mo agrego funciones a una obra?</a></li>
				<li><a href="#q6">�Puedo ver estad�sticas de una obra?</a></li>
				<li><a href="#q7">Ver listado completo de tickets de una funci�n pasada de cualquier obra</a></li>
				<li><a href="#q8">�Qu� hacer cuando los clientes no se presentan en boleter�a habiendo comprado bajo la opci�n "Pago por ventanilla"?</a></li>
				<li id="r1"><a href="#q9">Administrar usuarios existentes</a></li>
				<li><a href="#q10">Dar de alta un nuevo usuario</a></li>
			</ol>
		</div>
	<!-- Tabla de respuestas -->
		<div class="contentTable">
			<div id="q1">
				<h4 class="questionTitle">1. �C�mo ingresar una nueva obra al sistema?</h4>
				<p class="questionAnswer">Para dar de alta una nueva obra, debes presionar la opci�n <i>Obras</i> en el menu superior, al lado del �cono herramienta. Esto 
				te llevar� a la secci�n <i>Administrar Obras</i>. Luego debes presionar <b>Nueva obra</b>, completar los datos y hacer click en <b>Cargar</b>. Un mensaje te ser� 
				devuelto para asegurar que la obra se ha guardado con �xito.
				</p>
			</div>
			<div id="q2">
				<h4 class="questionTitle">2. �Necesito cargar una imagen para cada obra?</h4>
				<p class="questionAnswer">Ten en cuenta que Theatralia es una plataforma de venta, con lo cual es mucho m�s amigable para los clientes tener una imagen de referencia en las obras 
				que se publican. Si bien <u>no es necesario</u> cargar una imagen al momento de dar de alta una obra, <u>lo recomendamos ampliamente</u>. Cuando cargues una obra sin imagen, un mensaje 
				de sugerencia te ser� mostrado.
				</p>
			</div>
			<div id="q3">
				<h4 class="questionTitle">3. Cuando doy de alta una obra, �aparecer� en cartelera autom�ticamente?</h4>
				<p class="questionAnswer">No. La condici�n para que una obra aparezca en cartelera es si un administrador lo ha estipulado manualmente. Ning�n proceso de Theatralia pondr� en cartelera una obra autom�ticamente (ni la quitar�). <br>
				</p>
			</div>
			<div id="q4">
				<h4 class="questionTitle">4. �C�mo administro la cartelera?</h4>
				<p class="questionAnswer">La Cartelera es una secci�n administrada individualmente por los Administradores. Es decir, en <i>Programaci�n</i> pueden:</p>
				<ul>
					<li>figurar obras sin funciones pr�ximas</li>
					<li>no figurar obras que s� tengan funciones disponibles futuras</li>
				</ul>
				<p class="questionAnswer">Para administrar qu� obras aparecen en la Cartelera, debes dirigirte a la secci�n <i>Obras</i> en el men� superior al lado del �cono herramienta, buscar en la lista la obra deseada, y bajo la columna <i>En cartelera</i>, 
				puedes hacer click en las opciones <b>Si/No</b> para alternar que aparezca o no, respectivamente. <small>�La leyenda actualmente desplegada en esa columna es el estado actual de la obra!</small></p>
			</div>
			<div id="q5">
				<h4 class="questionTitle">5. �C�mo edito una obra?</h4>
				<p class="questionAnswer">Para editar una obra, desde el men� superior, junto al �cono herramienta:<br>
				<b>Obras ></b><i>Ubicar la obra deseada </i><b>> Editar</b>
				</p>
			</div>
			<div id="q6">
				<h4 class="questionTitle">6. �C�mo agrego funciones a una obra?</h4>
				<p class="questionAnswer">Para agregar funciones a una obra, desde el men� superior, junto al �cono herramienta:<br>
				<b>Obras ></b><i>Ubicar la obra deseada </i><b>> Editar</b><br>
				En la parte inferior de la secci�n editar ver�s las Funciones cargadas para dicha obra, como tambi�n cierta informaci�n asociada. 
				Selecciona la fecha, el monto de la entrada para dicha funci�n, y haz click en <b>Nueva funci�n</b>.<br>
				Ten en cuenta que el proceso puede demorar un par de minutos. Al finalizar, tu funci�n aparecer� listada en esta misma secci�n.
				</p>
			</div>	
			<div id="q7">
				<h4 class="questionTitle">7. �Puedo ver estad�sticas de una obra?</h4>
				<p class="questionAnswer">Las estad�sticas de una obra est�n disponibles en la secci�n de administraci�n de obras, bajo la columna <i>Estadisticas</i>, 
				haciendo click en <b>Ver</b>.<br>
				Aqu� ver�s, por cada funci�n:</p>
				<ul>
					<li>la fecha</li>
					<li>el monto de la entrada individual</li>
					<li>los asientos disponibles (de un total de 98)</li>
					<li>el total recaudado (asientos vendidos x monto individual)</li>
					<li>cantidad de tickets emitidos <small>(recuerda que un ticket puede tener varios asientos)</small></li>
					<li>porcentaje de tickets facturados, ya sea por ventanilla o por pago web || el n�mero total de tickets facturados</li>
					<li>un acceso a la lista de tickets emitidos</li>
					<li>un acceso a la disposici�n de la sala, en forma gr�fica, acorde a los asientos vendidos</li>
				</ul>
				<p class="questionAnswer"><small>(*)Ten en cuenta que esta lista puede ser exportada a Excel haciendo click en el �cono corresponidente en la secci�n superior de la p�gina</small></p>
			</div>		
			<div id="q8">
				<h4 class="questionTitle">8. Ver listado completo de tickets de una funci�n pasada de cualquier obra</h4>
				<p class="questionAnswer">Para ver el listado de todos los tickets emitidos para una funci�n, debes ir a <i>Obras</i> en el menu superior, al lado del �cono herramienta, 
				buscar la obra que desees y acceder a sus <b>estad�sticas</b>. Aqu� aparecer�n listadas todas las funciones de la obra. Para ver los tickets de la obra debes hacer click en <b>Ver lista</b> bajo la columna 
				<i>Lista de tickets</i>. Para acceder al ticket debes hacer click en su n�mero identificador, bajo la columna <i>Ticket id</i>.
				</p>
			</div>	
			<div id="q9">
				<h4 class="questionTitle">9. �Qu� hacer cuando los clientes no se presentan en boleter�a habiendo comprado bajo la opci�n "Pago por ventanilla"?</h4>
				<p class="questionAnswer">Ya que los clientes, al comprar bajo la opci�n "Pago por ventanilla" dejan asociada la tarjeta de la compra, al no presentarse a retirar por ventanilla (y abonar) queda como potestad 
				de los Administradores acceder a ejecutar el cobro a dicha tarjeta. Esto puede hacerse, comenzando por el men� superior: <br>
				<b>Tickets > Tickets vencidos > Cargar (ticket individual) / Cargar todos</b><br>
				<small>(*) Tanto los tickets pendientes de entrega como los expirados, son presentados en tablas que pueden ser exportadas a Excel mediante la opci�n correspondiente bajo la cabecera de la p�gina.</small>
				</p>
			</div>	
			<div id="q10">
				<h4 class="questionTitle">10. Administrar usuarios existentes</h4>
				<p class="questionAnswer">La administraci�n de los usuarios existentes es una funcionalidad muy sencilla en Theatralia, disponible en el men� superior, opci�n <i>Usuarios</i>, al lado del �cono herramienta. <br>
				Al ser redirigido al panel de administraci�n aparecer� una lista de todos los usuarios del sistema. </p>
				<ul>
					<li>Para <b>cambiar el estado</b> del usuario puede seleccionarse de la lista desplegable las opciones:
					<ul>
						<li><b>Activo:</b> con accesos por defecto a la plataforma</li>
						<li><b>Pendiente:</b> cuando requiera <i>revisi�n de algun tipo</i> por parte del personal del teatro. El usuario no podr� acceder a Theatralia</li>
						<li><b>Desactivado:</b> cuando se ha vetado el acceso del usuario al sistema</li>
					</ul>
					<li>Para <b>cambiar el rol</b> del usuario, bastar� con elegir uno de los tres roles disponibles: <b>Cliente, Vendedor, Administrador</b>.</li>
				</ul>
				<p class="questionAnswer"><small>(*) Ten en cuenta que esta lista puede ser exportada a Excel haciendo click en el �cono corresponidente en la secci�n superior de la p�gina</small></p>
			</div>
			<div id="11">
				<h4 class="questionTitle">11. Dar de alta un nuevo usuario</h4>
				<p class="questionAnswer">Un Administrador puede crear usuarios para nuevos empleados, ya sea en rol Empleado o Administrador. Dichos roles, por supuesto, pueden ser alterados con posterioridad.<br>
				Para dar de alta un nuevo usuario, d�rigite desde el men� superior, junto al �cono herramienta:<br>
				<b>Usuarios > (+) Nuevo usuario</b><br>
				Aqu� deber�s completar los datos del nuevo usuario y hacer click en <b>Cargar</b>. Una vez dado de alta el usuario, puedes editarlo cuando sea necesario.
				</p>
			</div>
		</div>

	<div class="subir">
		<small><i><a href="#faqstop">Volver al �ndice</a></i></small>
	</div>
	
    </div>
    <!-- /.container -->



    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
