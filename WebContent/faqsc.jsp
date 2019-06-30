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
		<a href="faqs?to=c" style="pointer-events: none; cursor: default; color: grey">Cliente / </a>
		<a href="faqs?to=e" style="color:#ff9955;">Empleado / </a>
		<%if(loggedUser.isAdmin()){ %>
		<a href="faqs?to=a" style="color:#ff9955;">Administrador</a>
	<%	}
	  }%>	
		<br/>
	<!-- Indice de preguntas -->	
		<div id="indexTable" class="indexTable" >
		<h2>Índice</h2>
			<ol>
				<li><a href="#p14">¿Qué es Thetralia?</a></li>
				<li><a href="#q1">¿Qué información personal tiene la plataforma?</a></li>
				<li><a href="#q2">¿Cómo edito mi información personal?</a></li>
				<li><a href="#q3">¿Cómo cambio mi contraseña?</a></li>
				<li><a href="#q4">¿Qué son mis métodos de pago? ¿Cómo se administran?</a></li>
				<li><a href="#q5">¿Cómo comprar por Theatralia?</a></li>
				<li><a href="#q6">Pagar con tarjeta o pagar por ventanilla</a></li>
				<li><a href="#q7">¿Debo retirar siempre mi entrada por boletería?</a></li>
				<li><a href="#q8">¿Qué es la Biblioteca? ¿Cómo accedo a ella?</a></li>
				<li><a href="#q9">Agregar / quitar obras de mi Biblioteca</a></li>
				<li><a href="#q10">¿Cómo encontrar obras?</a></li>
				<li><a href="#q11">¿Cómo encontrar usuarios?</a></li>
				<li><a href="#q12">¿Puedo dejar comentarios en una obra?</a></li>
				<li id="p14"><a href="#q13">¿Cómo interactúo con comentarios?</a></li>
				<li id="p15"><a href="#q14">¿Puedo recuperar mis tickets o mis códigos de delivery/entrega?</a></li>
			</ol>
		</div>
	<!-- Tabla de respuestas -->
		<div class="contentTable">
			<div id="q1">
				<h4 class="questionTitle">1. ¿Qué es Thetralia?</h4>
				<p class="questionAnswer">Theatralia es una plataforma multipróposito dirigida a los amantes del teatro para que puedan
				comprar entradas a obras y compartir con otros sus intereses y gustos artísticos.
				</p>
			</div>
			<div id="q2">
				<h4 class="questionTitle">2. ¿Qué información personal tiene la plataforma?</h4>
				<p class="questionAnswer">Para acceder a tu información personal solo debes hacer click en tu nombre, en el menú superior
				y accederás a tu página de perfil.
				</p>
			</div>
			<div id="q3">
				<h4 class="questionTitle">3. ¿Cómo edito mi información personal?</h4>
				<p class="questionAnswer">Para editar tu información personal solo debes seguir los siguientes pasos, comenzando por el menú superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Actualizar datos > Actualizar</b>
				</p>
			</div>
			<div id="q4">
				<h4 class="questionTitle">4. ¿Cómo cambio mi contraseña?</h4>
				<p class="questionAnswer">Para cambiar tu contaseña solo debes seguir los siguientes pasos, comenzando por el menú superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Cambiar contraseña > Cambiar</b>
				</p>
			</div>
			<div id="q5">
				<h4 class="questionTitle">5. ¿Qué son mis métodos de pago? ¿Cómo se administran?</h4>
				<p class="questionAnswer">Los métodos de pago son un requisito obligatorio para poder efectuar compras por la Theatralia. Para acceder a ellos, comenzando por el menú superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Ver mis métodos de pago</b> <br/>
				Desde este lugar puedes ver tus tarjetas de débito/crédito. Ten en cuenta que la información referida a los códigos de seguridad <b>sólo serán requeridos al momento de efectuar compras.</b> Theatralia <b>nunca guardará información referida a dígitos 
				veríficadores o códigos de seguridad.</b> 
				</p>
			</div>
			<div id="q6">
				<h4 class="questionTitle">6. ¿Cómo comprar por Theatralia?</h4>
				<p class="questionAnswer">Para comprar por Theatralia debes dirigirte a la sección <b>Programación</b>, que es donde se muestran las obras en cartelera. Bajo el título <u>Proximas funciones</u> se listarán las fechas y los asientos disponibles para las funciones futuras. 
				Para efectuar una compra debes ir a: <br>
				<b>Ver obra > Comprar > Seleccionar la función y método de pago > Continuar > Seleccionar los asientos entre los disponibles > Continuar > Completar datos de la tarjeta > Confirmar</b> <br>
				<small>(*)Ten en cuenta que si aún no has cargado tarjetas en tu perfil, no podrás realizar esta acción</small>
				</p>
			</div>
			<div id="q7">
				<h4 class="questionTitle">7. Pagar con tarjeta o pagar por ventanilla</h4>
				<p class="questionAnswer">A la hora de realizar una compra deberás seleccionar una de las dos opciones: <b>pagar con tarjeta o pagar por ventanilla.</b> Para el primer caso, 
				la compra se realizará y se cobrará de la tarjeta elegida al instante. En el segundo caso, no se efectuará recargo alguno a la tarjeta pero <b>sí quedará asociada la tarjeta a la compra.</b> Esto es así 
				debido a que siempre deberás pasar por boletería y retirar el ticket en persona. De no presentarte el día de la función (o alguno anterior), tu asiento ya ha sido reservado y eso haría incurrir en un costo a Theatralia. 
				A partir de este momento nuestros operadores pueden accionar el cobro de dicha entrada al medio de pago que haya quedado asociado la compra.
				</p>
			</div>
			<div id="q8">
				<h4 class="questionTitle">8. ¿Debo retirar siempre mi entrada por boletería?</h4>
				<p class="questionAnswer">Si, está dentro de las obligaciones del comprador presentarse en boletería a retirar su ticket impreso, independientemente 
				de la opción de pago que se haya utilizado para efectuar la compra. Con el código de delivery se efectuará dicha entrega, y de haber seleccionado <u>Pagar por ventanilla</u>, se 
				procederá a abonar la entrada en persona en ese mismo momento.
				</p>
			</div>
			<div id="q9">
				<h4 class="questionTitle">9. ¿Qué es la Biblioteca? ¿Cómo accedo a ella?</h4>
				<p class="questionAnswer">La Biblioteca es un lugar donde los usuarios pueden guardar aquellas obras que deseen, ya sea porque les han gustado, las han visto, 
				quieren verlas, o cualquier otra razón. Ten en cuenta que las obras agregadas a tu Biblioteca serán visibles para otros usuarios, pues forma parte de tu perfil 
				público. De esta manera, el resto de los usuarios pueden hacerse una idea de tus gustos e intereses, y compartir contigo en base a esta información.
				Para acceder a tu Biblioteca, comenzando por el menú superior: <br>
				<b><%=loggedUser.getName() %> > [Sección] Biblioteca</b>
				</p>
			</div>
			<div id="q10">
				<h4 class="questionTitle">10. Agregar / quitar obras de mi Biblioteca</h4>
				<p class="questionAnswer">Para agregar una obra a tu biblioteca debes estar en la página de la obra en cuestión. Bajo la sección <u>Próximas funciones</u> 
				deberás ver el botón <b>(+)Biblioteca</b>. Al hacer click en él, la obra ya aparecerá en tu perfil. Desde esta misma página, o desde la sección Biblioteca 
				en tu perfil, verás el botón <b>(-)Biblioteca</b> para quitarla de la lista y que deje de estar visible en tu perfil.
				</p>
			</div>
			<div id="q11">
				<h4 class="questionTitle">11. ¿Cómo encontrar obras?</h4>
				<p class="questionAnswer">Hay varias maneras de acceder las páginas de las obras, pero las más usuales son a través de la sección <u>Programación</u> o mediante la búsqueda por nombre. Para buscar por nombre 
				debes hacer click en la opción <b>Obras</b>, la cual tiene una lupa, en el menú superior. Luego hacer click en la lupa en mitad de pantalla, escribir el nombre (o parte de él) en pantalla y presionar la tecla <i>Enter</i> del teclado. 
				A lo largo de la plataforma, otras formas de acceder a las páginas de las obras son posibles, casi siempre haciendo click sobre el nombre de la misma. 
				</p>
			</div>
			<div id="q12">
				<h4 class="questionTitle">12. ¿Cómo encontrar usuarios?</h4>
				<p class="questionAnswer">Para acceder a las página de perfil de otro usuario, la manera más conveniente es usando el buscador dedicado para ello, a través de la opción <b>Usuarios</b>, al lado del ícono lupa en el menú superior. 
				Una vez en la página de búsqueda, volver a presionar la lupa, escribir el nombre o parte de él, y hacer click en la tecla <i>Enter</i> del teclado. Una lista de usuarios coincidente con los criterios de búsqueda aparecerá. Hacer 
				click sobre alguno de estos elementos resultado nos llevará al sitio del perfil del mismo. 
				</p>
			</div>
			<div id="q13">
				<h4 class="questionTitle">13. ¿Puedo dejar comentarios en una obra?</h4>
				<p class="questionAnswer">Es posible comentar una obra desde la página dedicada a ella. En la sección inferior encontrarás un cuadro de texto con la entrada <i>¡Comenta, no seas tímido!</i>. Solo debes escribir y expresarte. Al final 
				solo presiona <i>Enter</i> y tu comentario será guardado. ¡Ten en cuenta que los comentarios son públicos y todo el mundo podrá verlos y comentar sobre ellos, además de sobre la obra en sí!. Te pedimos respetes las normas de la comunidad, 
				mantengas un lenguaje apropiado y un estilo bienintencionado, ya que nuestros moderadores pueden considerar ésto argumento suficiente para bloquearte el acceso al sitio.
				</p>
			</div>
			<div id="q14">
				<h4 class="questionTitle">14. ¿Cómo interactúo con comentarios?</h4>
				<p class="questionAnswer">Invitamos a los miembros del portal a que interactúen con comentarios de terceros, dándoles like, haciéndo click en los corazones bajo éstos, o comentando a ellos 
				haciendo click en la flecha naranja.
				Al hacer click en la flecha naranja serás redirigido al cuadro texto y notarás que el mensaje ha cambiado a <i>Contéstale a ...</i>. Así es como sabrás cuándo estás comentando sobre la obra, y cuándo sobre otro comentario.
				</p>
			</div>
			<div id="q15">
				<h4 class="questionTitle">15. ¿Puedo recuperar mis tickets o mis códigos de delivery/entrega?</h4>
				<p class="questionAnswer">Si no has impreso tu ticket o anotado tu código de entrega, es posible acceder a <b>todos los tickets que hayas comprado por la plataforma,</b> independientemente del método de pago que hayas seleccionado. <br>
				Para hacer esto, desde el menú superior: <br>
				<b><%=loggedUser.getName() %> > Mis Tickets</b> <br>
				Aquí verás una lista ordenada (cuyo órden puedes alterar haciendo click en el nombre de cada columna) con toda la información referida a tus compras por Theatralia. <br>
				Para ver el ticket en cuestión, haz click sobre el número <b>Id</b> de la compra. <br>
				Para ver la obra, haz click sobre el nombre de la misma. <br>
				<b>Entregado</b> hace referencia a todos los tickets que hayas retirado por boletería. <br>
				<b>Pagado</b> hace referencia a todos los tickets que hayas pagado, ya sea por haber hecho la compra con la opción <u>Pagar con tarjeta</u>, cuyo pago es inmediato, o por haber abonado en boletería al realizar el retiro.
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
