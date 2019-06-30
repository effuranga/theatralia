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
		<a href="faqs?to=c" style="pointer-events: none; cursor: default; color: grey">Cliente / </a>
		<a href="faqs?to=e" style="color:#ff9955;">Empleado / </a>
		<%if(loggedUser.isAdmin()){ %>
		<a href="faqs?to=a" style="color:#ff9955;">Administrador</a>
	<%	}
	  }%>	
		<br/>
	<!-- Indice de preguntas -->	
		<div id="indexTable" class="indexTable" >
		<h2>�ndice</h2>
			<ol>
				<li><a href="#p14">�Qu� es Thetralia?</a></li>
				<li><a href="#q1">�Qu� informaci�n personal tiene la plataforma?</a></li>
				<li><a href="#q2">�C�mo edito mi informaci�n personal?</a></li>
				<li><a href="#q3">�C�mo cambio mi contrase�a?</a></li>
				<li><a href="#q4">�Qu� son mis m�todos de pago? �C�mo se administran?</a></li>
				<li><a href="#q5">�C�mo comprar por Theatralia?</a></li>
				<li><a href="#q6">Pagar con tarjeta o pagar por ventanilla</a></li>
				<li><a href="#q7">�Debo retirar siempre mi entrada por boleter�a?</a></li>
				<li><a href="#q8">�Qu� es la Biblioteca? �C�mo accedo a ella?</a></li>
				<li><a href="#q9">Agregar / quitar obras de mi Biblioteca</a></li>
				<li><a href="#q10">�C�mo encontrar obras?</a></li>
				<li><a href="#q11">�C�mo encontrar usuarios?</a></li>
				<li><a href="#q12">�Puedo dejar comentarios en una obra?</a></li>
				<li id="p14"><a href="#q13">�C�mo interact�o con comentarios?</a></li>
				<li id="p15"><a href="#q14">�Puedo recuperar mis tickets o mis c�digos de delivery/entrega?</a></li>
			</ol>
		</div>
	<!-- Tabla de respuestas -->
		<div class="contentTable">
			<div id="q1">
				<h4 class="questionTitle">1. �Qu� es Thetralia?</h4>
				<p class="questionAnswer">Theatralia es una plataforma multipr�posito dirigida a los amantes del teatro para que puedan
				comprar entradas a obras y compartir con otros sus intereses y gustos art�sticos.
				</p>
			</div>
			<div id="q2">
				<h4 class="questionTitle">2. �Qu� informaci�n personal tiene la plataforma?</h4>
				<p class="questionAnswer">Para acceder a tu informaci�n personal solo debes hacer click en tu nombre, en el men� superior
				y acceder�s a tu p�gina de perfil.
				</p>
			</div>
			<div id="q3">
				<h4 class="questionTitle">3. �C�mo edito mi informaci�n personal?</h4>
				<p class="questionAnswer">Para editar tu informaci�n personal solo debes seguir los siguientes pasos, comenzando por el men� superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Actualizar datos > Actualizar</b>
				</p>
			</div>
			<div id="q4">
				<h4 class="questionTitle">4. �C�mo cambio mi contrase�a?</h4>
				<p class="questionAnswer">Para cambiar tu contase�a solo debes seguir los siguientes pasos, comenzando por el men� superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Cambiar contrase�a > Cambiar</b>
				</p>
			</div>
			<div id="q5">
				<h4 class="questionTitle">5. �Qu� son mis m�todos de pago? �C�mo se administran?</h4>
				<p class="questionAnswer">Los m�todos de pago son un requisito obligatorio para poder efectuar compras por la Theatralia. Para acceder a ellos, comenzando por el men� superior: <br/>
				<b><%=loggedUser.getName() %> > Editar > Ver mis m�todos de pago</b> <br/>
				Desde este lugar puedes ver tus tarjetas de d�bito/cr�dito. Ten en cuenta que la informaci�n referida a los c�digos de seguridad <b>s�lo ser�n requeridos al momento de efectuar compras.</b> Theatralia <b>nunca guardar� informaci�n referida a d�gitos 
				ver�ficadores o c�digos de seguridad.</b> 
				</p>
			</div>
			<div id="q6">
				<h4 class="questionTitle">6. �C�mo comprar por Theatralia?</h4>
				<p class="questionAnswer">Para comprar por Theatralia debes dirigirte a la secci�n <b>Programaci�n</b>, que es donde se muestran las obras en cartelera. Bajo el t�tulo <u>Proximas funciones</u> se listar�n las fechas y los asientos disponibles para las funciones futuras. 
				Para efectuar una compra debes ir a: <br>
				<b>Ver obra > Comprar > Seleccionar la funci�n y m�todo de pago > Continuar > Seleccionar los asientos entre los disponibles > Continuar > Completar datos de la tarjeta > Confirmar</b> <br>
				<small>(*)Ten en cuenta que si a�n no has cargado tarjetas en tu perfil, no podr�s realizar esta acci�n</small>
				</p>
			</div>
			<div id="q7">
				<h4 class="questionTitle">7. Pagar con tarjeta o pagar por ventanilla</h4>
				<p class="questionAnswer">A la hora de realizar una compra deber�s seleccionar una de las dos opciones: <b>pagar con tarjeta o pagar por ventanilla.</b> Para el primer caso, 
				la compra se realizar� y se cobrar� de la tarjeta elegida al instante. En el segundo caso, no se efectuar� recargo alguno a la tarjeta pero <b>s� quedar� asociada la tarjeta a la compra.</b> Esto es as� 
				debido a que siempre deber�s pasar por boleter�a y retirar el ticket en persona. De no presentarte el d�a de la funci�n (o alguno anterior), tu asiento ya ha sido reservado y eso har�a incurrir en un costo a Theatralia. 
				A partir de este momento nuestros operadores pueden accionar el cobro de dicha entrada al medio de pago que haya quedado asociado la compra.
				</p>
			</div>
			<div id="q8">
				<h4 class="questionTitle">8. �Debo retirar siempre mi entrada por boleter�a?</h4>
				<p class="questionAnswer">Si, est� dentro de las obligaciones del comprador presentarse en boleter�a a retirar su ticket impreso, independientemente 
				de la opci�n de pago que se haya utilizado para efectuar la compra. Con el c�digo de delivery se efectuar� dicha entrega, y de haber seleccionado <u>Pagar por ventanilla</u>, se 
				proceder� a abonar la entrada en persona en ese mismo momento.
				</p>
			</div>
			<div id="q9">
				<h4 class="questionTitle">9. �Qu� es la Biblioteca? �C�mo accedo a ella?</h4>
				<p class="questionAnswer">La Biblioteca es un lugar donde los usuarios pueden guardar aquellas obras que deseen, ya sea porque les han gustado, las han visto, 
				quieren verlas, o cualquier otra raz�n. Ten en cuenta que las obras agregadas a tu Biblioteca ser�n visibles para otros usuarios, pues forma parte de tu perfil 
				p�blico. De esta manera, el resto de los usuarios pueden hacerse una idea de tus gustos e intereses, y compartir contigo en base a esta informaci�n.
				Para acceder a tu Biblioteca, comenzando por el men� superior: <br>
				<b><%=loggedUser.getName() %> > [Secci�n] Biblioteca</b>
				</p>
			</div>
			<div id="q10">
				<h4 class="questionTitle">10. Agregar / quitar obras de mi Biblioteca</h4>
				<p class="questionAnswer">Para agregar una obra a tu biblioteca debes estar en la p�gina de la obra en cuesti�n. Bajo la secci�n <u>Pr�ximas funciones</u> 
				deber�s ver el bot�n <b>(+)Biblioteca</b>. Al hacer click en �l, la obra ya aparecer� en tu perfil. Desde esta misma p�gina, o desde la secci�n Biblioteca 
				en tu perfil, ver�s el bot�n <b>(-)Biblioteca</b> para quitarla de la lista y que deje de estar visible en tu perfil.
				</p>
			</div>
			<div id="q11">
				<h4 class="questionTitle">11. �C�mo encontrar obras?</h4>
				<p class="questionAnswer">Hay varias maneras de acceder las p�ginas de las obras, pero las m�s usuales son a trav�s de la secci�n <u>Programaci�n</u> o mediante la b�squeda por nombre. Para buscar por nombre 
				debes hacer click en la opci�n <b>Obras</b>, la cual tiene una lupa, en el men� superior. Luego hacer click en la lupa en mitad de pantalla, escribir el nombre (o parte de �l) en pantalla y presionar la tecla <i>Enter</i> del teclado. 
				A lo largo de la plataforma, otras formas de acceder a las p�ginas de las obras son posibles, casi siempre haciendo click sobre el nombre de la misma. 
				</p>
			</div>
			<div id="q12">
				<h4 class="questionTitle">12. �C�mo encontrar usuarios?</h4>
				<p class="questionAnswer">Para acceder a las p�gina de perfil de otro usuario, la manera m�s conveniente es usando el buscador dedicado para ello, a trav�s de la opci�n <b>Usuarios</b>, al lado del �cono lupa en el men� superior. 
				Una vez en la p�gina de b�squeda, volver a presionar la lupa, escribir el nombre o parte de �l, y hacer click en la tecla <i>Enter</i> del teclado. Una lista de usuarios coincidente con los criterios de b�squeda aparecer�. Hacer 
				click sobre alguno de estos elementos resultado nos llevar� al sitio del perfil del mismo. 
				</p>
			</div>
			<div id="q13">
				<h4 class="questionTitle">13. �Puedo dejar comentarios en una obra?</h4>
				<p class="questionAnswer">Es posible comentar una obra desde la p�gina dedicada a ella. En la secci�n inferior encontrar�s un cuadro de texto con la entrada <i>�Comenta, no seas t�mido!</i>. Solo debes escribir y expresarte. Al final 
				solo presiona <i>Enter</i> y tu comentario ser� guardado. �Ten en cuenta que los comentarios son p�blicos y todo el mundo podr� verlos y comentar sobre ellos, adem�s de sobre la obra en s�!. Te pedimos respetes las normas de la comunidad, 
				mantengas un lenguaje apropiado y un estilo bienintencionado, ya que nuestros moderadores pueden considerar �sto argumento suficiente para bloquearte el acceso al sitio.
				</p>
			</div>
			<div id="q14">
				<h4 class="questionTitle">14. �C�mo interact�o con comentarios?</h4>
				<p class="questionAnswer">Invitamos a los miembros del portal a que interact�en con comentarios de terceros, d�ndoles like, haci�ndo click en los corazones bajo �stos, o comentando a ellos 
				haciendo click en la flecha naranja.
				Al hacer click en la flecha naranja ser�s redirigido al cuadro texto y notar�s que el mensaje ha cambiado a <i>Cont�stale a ...</i>. As� es como sabr�s cu�ndo est�s comentando sobre la obra, y cu�ndo sobre otro comentario.
				</p>
			</div>
			<div id="q15">
				<h4 class="questionTitle">15. �Puedo recuperar mis tickets o mis c�digos de delivery/entrega?</h4>
				<p class="questionAnswer">Si no has impreso tu ticket o anotado tu c�digo de entrega, es posible acceder a <b>todos los tickets que hayas comprado por la plataforma,</b> independientemente del m�todo de pago que hayas seleccionado. <br>
				Para hacer esto, desde el men� superior: <br>
				<b><%=loggedUser.getName() %> > Mis Tickets</b> <br>
				Aqu� ver�s una lista ordenada (cuyo �rden puedes alterar haciendo click en el nombre de cada columna) con toda la informaci�n referida a tus compras por Theatralia. <br>
				Para ver el ticket en cuesti�n, haz click sobre el n�mero <b>Id</b> de la compra. <br>
				Para ver la obra, haz click sobre el nombre de la misma. <br>
				<b>Entregado</b> hace referencia a todos los tickets que hayas retirado por boleter�a. <br>
				<b>Pagado</b> hace referencia a todos los tickets que hayas pagado, ya sea por haber hecho la compra con la opci�n <u>Pagar con tarjeta</u>, cuyo pago es inmediato, o por haber abonado en boleter�a al realizar el retiro.
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
