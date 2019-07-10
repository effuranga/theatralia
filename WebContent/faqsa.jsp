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
      <h1 id="faqstop" class="my-4">Preguntas frecuentes / Cómo usar
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
		<h2>Índice</h2>
			<ol>
				<li><a href="#r1">¿Cómo ingresar una nueva obra al sistema?</a></li>
				<li><a href="#q1">¿Necesito cargar una imagen para cada obra?</a></li>
				<li><a href="#q2">Cuando doy de alta una obra, ¿aparecerá en cartelera automáticamente?</a></li>
				<li><a href="#q3">¿Cómo administro la cartelera?</a></li>
				<li><a href="#q4">¿Cómo edito una obra?</a></li>
				<li><a href="#q5">¿Cómo agrego funciones a una obra?</a></li>
				<li><a href="#q6">¿Puedo ver estadísticas de una obra?</a></li>
				<li><a href="#q7">Ver listado completo de tickets de una función pasada de cualquier obra</a></li>
				<li><a href="#q8">¿Qué hacer cuando los clientes no se presentan en boletería habiendo comprado bajo la opción "Pago por ventanilla"?</a></li>
				<li id="r1"><a href="#q9">Administrar usuarios existentes</a></li>
				<li><a href="#q10">Dar de alta un nuevo usuario</a></li>
			</ol>
		</div>
	<!-- Tabla de respuestas -->
		<div class="contentTable">
			<div id="q1">
				<h4 class="questionTitle">1. ¿Cómo ingresar una nueva obra al sistema?</h4>
				<p class="questionAnswer">Para dar de alta una nueva obra, debes presionar la opción <i>Obras</i> en el menu superior, al lado del ícono herramienta. Esto 
				te llevará a la sección <i>Administrar Obras</i>. Luego debes presionar <b>Nueva obra</b>, completar los datos y hacer click en <b>Cargar</b>. Un mensaje te será 
				devuelto para asegurar que la obra se ha guardado con éxito.
				</p>
			</div>
			<div id="q2">
				<h4 class="questionTitle">2. ¿Necesito cargar una imagen para cada obra?</h4>
				<p class="questionAnswer">Ten en cuenta que Theatralia es una plataforma de venta, con lo cual es mucho más amigable para los clientes tener una imagen de referencia en las obras 
				que se publican. Si bien <u>no es necesario</u> cargar una imagen al momento de dar de alta una obra, <u>lo recomendamos ampliamente</u>. Cuando cargues una obra sin imagen, un mensaje 
				de sugerencia te será mostrado.
				</p>
			</div>
			<div id="q3">
				<h4 class="questionTitle">3. Cuando doy de alta una obra, ¿aparecerá en cartelera automáticamente?</h4>
				<p class="questionAnswer">No. La condición para que una obra aparezca en cartelera es si un administrador lo ha estipulado manualmente. Ningún proceso de Theatralia pondrá en cartelera una obra automáticamente (ni la quitará). <br>
				</p>
			</div>
			<div id="q4">
				<h4 class="questionTitle">4. ¿Cómo administro la cartelera?</h4>
				<p class="questionAnswer">La Cartelera es una sección administrada individualmente por los Administradores. Es decir, en <i>Programación</i> pueden:</p>
				<ul>
					<li>figurar obras sin funciones próximas</li>
					<li>no figurar obras que sí tengan funciones disponibles futuras</li>
				</ul>
				<p class="questionAnswer">Para administrar qué obras aparecen en la Cartelera, debes dirigirte a la sección <i>Obras</i> en el menú superior al lado del ícono herramienta, buscar en la lista la obra deseada, y bajo la columna <i>En cartelera</i>, 
				puedes hacer click en las opciones <b>Si/No</b> para alternar que aparezca o no, respectivamente. <small>¡La leyenda actualmente desplegada en esa columna es el estado actual de la obra!</small></p>
			</div>
			<div id="q5">
				<h4 class="questionTitle">5. ¿Cómo edito una obra?</h4>
				<p class="questionAnswer">Para editar una obra, desde el menú superior, junto al ícono herramienta:<br>
				<b>Obras ></b><i>Ubicar la obra deseada </i><b>> Editar</b>
				</p>
			</div>
			<div id="q6">
				<h4 class="questionTitle">6. ¿Cómo agrego funciones a una obra?</h4>
				<p class="questionAnswer">Para agregar funciones a una obra, desde el menú superior, junto al ícono herramienta:<br>
				<b>Obras ></b><i>Ubicar la obra deseada </i><b>> Editar</b><br>
				En la parte inferior de la sección editar verás las Funciones cargadas para dicha obra, como también cierta información asociada. 
				Selecciona la fecha, el monto de la entrada para dicha función, y haz click en <b>Nueva función</b>.<br>
				Ten en cuenta que el proceso puede demorar un par de minutos. Al finalizar, tu función aparecerá listada en esta misma sección.
				</p>
			</div>	
			<div id="q7">
				<h4 class="questionTitle">7. ¿Puedo ver estadísticas de una obra?</h4>
				<p class="questionAnswer">Las estadísticas de una obra están disponibles en la sección de administración de obras, bajo la columna <i>Estadisticas</i>, 
				haciendo click en <b>Ver</b>.<br>
				Aquí verás, por cada función:</p>
				<ul>
					<li>la fecha</li>
					<li>el monto de la entrada individual</li>
					<li>los asientos disponibles (de un total de 98)</li>
					<li>el total recaudado (asientos vendidos x monto individual)</li>
					<li>cantidad de tickets emitidos <small>(recuerda que un ticket puede tener varios asientos)</small></li>
					<li>porcentaje de tickets facturados, ya sea por ventanilla o por pago web || el número total de tickets facturados</li>
					<li>un acceso a la lista de tickets emitidos</li>
					<li>un acceso a la disposición de la sala, en forma gráfica, acorde a los asientos vendidos</li>
				</ul>
				<p class="questionAnswer"><small>(*)Ten en cuenta que esta lista puede ser exportada a Excel haciendo click en el ícono corresponidente en la sección superior de la página</small></p>
			</div>		
			<div id="q8">
				<h4 class="questionTitle">8. Ver listado completo de tickets de una función pasada de cualquier obra</h4>
				<p class="questionAnswer">Para ver el listado de todos los tickets emitidos para una función, debes ir a <i>Obras</i> en el menu superior, al lado del ícono herramienta, 
				buscar la obra que desees y acceder a sus <b>estadísticas</b>. Aquí aparecerán listadas todas las funciones de la obra. Para ver los tickets de la obra debes hacer click en <b>Ver lista</b> bajo la columna 
				<i>Lista de tickets</i>. Para acceder al ticket debes hacer click en su número identificador, bajo la columna <i>Ticket id</i>.
				</p>
			</div>	
			<div id="q9">
				<h4 class="questionTitle">9. ¿Qué hacer cuando los clientes no se presentan en boletería habiendo comprado bajo la opción "Pago por ventanilla"?</h4>
				<p class="questionAnswer">Ya que los clientes, al comprar bajo la opción "Pago por ventanilla" dejan asociada la tarjeta de la compra, al no presentarse a retirar por ventanilla (y abonar) queda como potestad 
				de los Administradores acceder a ejecutar el cobro a dicha tarjeta. Esto puede hacerse, comenzando por el menú superior: <br>
				<b>Tickets > Tickets vencidos > Cargar (ticket individual) / Cargar todos</b><br>
				<small>(*) Tanto los tickets pendientes de entrega como los expirados, son presentados en tablas que pueden ser exportadas a Excel mediante la opción correspondiente bajo la cabecera de la página.</small>
				</p>
			</div>	
			<div id="q10">
				<h4 class="questionTitle">10. Administrar usuarios existentes</h4>
				<p class="questionAnswer">La administración de los usuarios existentes es una funcionalidad muy sencilla en Theatralia, disponible en el menú superior, opción <i>Usuarios</i>, al lado del ícono herramienta. <br>
				Al ser redirigido al panel de administración aparecerá una lista de todos los usuarios del sistema. </p>
				<ul>
					<li>Para <b>cambiar el estado</b> del usuario puede seleccionarse de la lista desplegable las opciones:
					<ul>
						<li><b>Activo:</b> con accesos por defecto a la plataforma</li>
						<li><b>Pendiente:</b> cuando requiera <i>revisión de algun tipo</i> por parte del personal del teatro. El usuario no podrá acceder a Theatralia</li>
						<li><b>Desactivado:</b> cuando se ha vetado el acceso del usuario al sistema</li>
					</ul>
					<li>Para <b>cambiar el rol</b> del usuario, bastará con elegir uno de los tres roles disponibles: <b>Cliente, Vendedor, Administrador</b>.</li>
				</ul>
				<p class="questionAnswer"><small>(*) Ten en cuenta que esta lista puede ser exportada a Excel haciendo click en el ícono corresponidente en la sección superior de la página</small></p>
			</div>
			<div id="11">
				<h4 class="questionTitle">11. Dar de alta un nuevo usuario</h4>
				<p class="questionAnswer">Un Administrador puede crear usuarios para nuevos empleados, ya sea en rol Empleado o Administrador. Dichos roles, por supuesto, pueden ser alterados con posterioridad.<br>
				Para dar de alta un nuevo usuario, dírigite desde el menú superior, junto al ícono herramienta:<br>
				<b>Usuarios > (+) Nuevo usuario</b><br>
				Aquí deberás completar los datos del nuevo usuario y hacer click en <b>Cargar</b>. Una vez dado de alta el usuario, puedes editarlo cuando sea necesario.
				</p>
			</div>
		</div>

	<div class="subir">
		<small><i><a href="#faqstop">Volver al índice</a></i></small>
	</div>
	
    </div>
    <!-- /.container -->



    <!-- Bootstrap core JavaScript -->
    <script src="dashboardFE/vendor/jquery/jquery.min.js"></script>
    <script src="dashboardFE/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  </body>

</html>
