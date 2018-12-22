<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String action = request.getParameter("action");
String message = "";
String redirect = "";
switch(action){
	case "1": //Validacion al crear tarjeta
		message = "Estamos validando sus datos. No cierre el navegador. Esta operacion puede tardar varios minutos.";
		redirect = "mycards?message="+request.getAttribute("message");
		break;
	case "2": //Imprimir ticket	
		message = "Imprimiendo ticket...";
		redirect = "home";
	case "3": //Imprimir ticket desde la entrega	
		message = "Imprimiendo ticket...";
		redirect = "delivery?action=delivery";
	case "4": //Cobrar ticket desde caja	
		message = "Dando ticket por cobrado...";
		redirect = "delivery?action=pay";
	case "5": //Cargar en la tarjeta el monto de un ticket particular	
		message = "Cargando monto...";
		redirect = "expiredticket?action=singlecharge";
}
%>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validating...</title>
</head>
<body>

<p><%=message %></p>
<img src="utils/spinner.gif" 
style="
margin-left:45%;
margin-top:5%;
"
/>



</body>
</html>

<script type="text/javascript">   
    function Redirect() 
    {  
        window.location="<%=redirect %>"; 
    } 
    setTimeout('Redirect()',5*1000);   
</script>
