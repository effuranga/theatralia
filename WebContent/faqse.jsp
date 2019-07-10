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
		<a href="faqs?to=e" style="pointer-events: none; cursor: default; color: grey;">Empleado / </a>
		<%if(loggedUser.isAdmin()){ %>
		<a href="faqs?to=a" style="color:#ff9955;">Administrador</a>
	<%	}
	  }%>	
		<br/>
	<!-- Indice de preguntas -->	
		<div id="indexTable" class="indexTable" >
		<h2>Índice</h2>
			<ol>
				<li><a href="#r1">¿Cómo vender entradas?</a></li>
				<li id="r1"><a href="#q1">¿Qué hacer cuando un cliente se presenta para retirar tickets?</a></li>
				<li><a href="#q2">Un cliente ha perdido sus boletos, ¿puedo reimprimirlos?</a></li>
			</ol>
		</div>
	<!-- Tabla de respuestas -->
		<div class="contentTable">
			<div id="q1">
				<h4 class="questionTitle">1. ¿Cómo vender entradas?</h4>
				<p class="questionAnswer">Vender entradas es muy simple. Desde la sección <i>Programación</i> selecciona cualquier obra con <i>Próximas funciones</i> disponibles. 
				Haz click en <b>Ver obra</b>. Bajo la descripción de la obra verás un campo desplegable para seleccionar la función que desees. Luego de seleccionar la fecha, haz click 
				en <b>Vender</b>. <br>
				Al ser redirigido a la página de la sala, selecciona los asientos según las preferencias del cliente y haz click en <b>Continuar</b>. <br>
				Al ser redirigido a la página de confirmación, deberás validar que todos los datos sean correctos, y de ser así presiona <b>Confirmar</b>. Será tu obligación imprimir el ticket 
				en este momento presionando <b>Imprimir</b>.
				</p>
			</div>
			<div id="q2">
				<h4 class="questionTitle">2. ¿Qué hacer cuando un cliente se presenta para retirar tickets?</h4>
				<p class="questionAnswer">Cuando un cliente se presente en boletería deberás pedirle su <i>código de delivery</i>, el cual es esencial para asegurar que fue él quién realizó la compra online.<br>
				Adicionalmente puedes pedirle un documento de identificación como medida de seguridad extra.<br>
				Deberás hacer el click en la opción de menu <i>Tickets</i>. Aquí aparecerán listados <u>todos (y solo) los tickets de funciones del día de hoy o futuras, aún no entregados.</u> Puedes buscar a mano en la tabla por 
				nombre de cliente, o por el mismo delivery code en la sección <i>search</i>.</p>
				<ul>
					<li>Si el cliente no pagó, verás bajo la columna <i>Pago</i> la palabra <i>No</i>. Deberás proceder a facturarle de manera electrónica o con efectivo en dicho momento. Una vez 
					finalizado este proceso, deberás hacer click en la opción <b>Cobrar</b> y luego en <b>Aceptar</b>, en el cuadro de confirmación. De esta manera se habilitará la opción <b>Entregar</b>, en la cual 
					luego de hacer click se imprimirá el ticket y desaparecerá de la lista.</li>
					<li>Si el cliente ya pagó, verás bajo la columna <i>Pago</i> la palabra <i>Si</i>. Esto indica que, o bien ha realizado el pago con la tarjeta de crédito, o se ha presentado con anterioridad en boletería 
					donde le han facturado pero no aún entregado la entrada. Deberás hacer click en <b>Entregar</b>, donde se imprimirá el boleto y desaparecerá de la lista.</li>
				</ul>				
			</div>
			<div id="q3">
				<h4 class="questionTitle">3. Un cliente ha perdido sus boletos, ¿puedo reimprimirlos?</h4>
				<p class="questionAnswer">La reimpresión de tickets es una funcionalidad válida de Theatralia, pero <u>está restringida a los Administradores</u>. Si eres un administrador, consulta la sección de FAQs de Administradores, en 
				caso contrario, haz favor de contactar a uno.
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
