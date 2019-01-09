package utils;

import business.User;

public class Header {
	public static String getHeader(User loggedUser, String index) {
		String searchplay = "";
		String searchuser = "";
		String tickets = "";
		String adminusers = "";
		String adminplays = "";
		String dashboard = "";
		String profile = "";
		
		switch(index) {
			case "searchplay": searchplay = "active";
					break;
			case "searchuser": searchuser = "active";
					break;
			case "tickets": tickets = "active";
					break;
			case "adminusers": adminusers = "active";
					break;
			case "adminplays": adminplays = "active";
					break;
			case "dashboard": dashboard = "active";
					break;
			case "profile": profile = "active";
					break;
		}
		
		String header = "<!-- Navigation -->\r\n" + 
				"    <nav class=\"navbar navbar-expand-lg navbar-dark bg-dark fixed-top\">\r\n" + 
				"      <div class=\"container\">\r\n" + 
				"        <a class=\"navbar-brand\" href=\"home\">Theatralia</a>\r\n" + 
				"        <button class=\"navbar-toggler\" type=\"button\" data-toggle=\"collapse\" data-target=\"#navbarResponsive\" aria-controls=\"navbarResponsive\" aria-expanded=\"false\" aria-label=\"Toggle navigation\">\r\n" + 
				"          <span class=\"navbar-toggler-icon\"></span>\r\n" + 
				"        </button>\r\n" + 
				"        <div class=\"collapse navbar-collapse\" id=\"navbarResponsive\">\r\n" + 
				"          <ul class=\"navbar-nav ml-auto\">\r\n" + 
				"          	<li class=\"nav-item "+searchplay+"\">\r\n" + 
				"              <a class=\"nav-link\" href=\"search.jsp\"><img src=\"homeFE/img/search.svg\" height=\"20\" width=\"20\" />Obras</a>\r\n" + 
				"            </li>  \r\n" + 
				"            <li class=\"nav-item "+searchuser+"\">\r\n" + 
				"              <a class=\"nav-link\" href=\"searchuser.jsp\"><img src=\"homeFE/img/search.svg\" height=\"20\" width=\"20\" />Usuarios</a>\r\n" + 
				"            </li>\r\n"; 

				          if(!loggedUser.isClient()){
				        	  header+= 
				        			  "        	<li class=\"nav-item "+tickets+"\">\r\n" + 
				        						"              <a class=\"nav-link\" href=\"delivery\"><img src=\"homeFE/img/ticket.png\" height=\"16\" width=\"16\" /> Tickets</a>\r\n" + 
				        						"            </li>  \r\n";
				          }
				          if(loggedUser.isAdmin()){
				        	  header+=
				        			  			"<li class=\"nav-item "+adminusers+"\">\r\n" + 
				        						"              <a class=\"nav-link\" href=\"adminusers\"><img src=\"homeFE/img/admin.png\" height=\"16\" width=\"16\" /> Users</a>\r\n" + 
				        						"            </li>\r\n" + 
				        						"          	<li class=\"nav-item "+adminplays+"\">\r\n" + 
				        						"              <a class=\"nav-link\" href=\"adminplays\"><img src=\"homeFE/img/admin.png\" height=\"16\" width=\"16\" /> Obras</a>\r\n" + 
				        						"            </li>\r\n";
				          }
				          header+=
				"            <li class=\"nav-item "+dashboard+"\">\r\n" + 
				"              <a class=\"nav-link\" href=\"home\"><img src=\"homeFE/img/list.png\" height=\"16\" width=\"16\" /> Programación</a>\r\n" + 
				"            </li>\r\n" + 
				"            <li class=\"nav-item "+profile+"\">\r\n" + 
				"              <a class=\"nav-link\" href=\"viewuser?requestedUserId="+loggedUser.getUserId()+"\"><img src=\"homeFE/img/user.png\" height=\"16\" width=\"16\" /> "+loggedUser.getName()+"</a>\r\n" + 
				"            </li>\r\n" + 
				"            <li class=\"nav-item\">\r\n" + 
				"              <a class=\"nav-link\" href=\"logout\"><img src=\"homeFE/img/logout.svg\" height=\"16\" width=\"16\" /> Salir</a>\r\n" + 
				"            </li>\r\n" + 
				"          </ul>\r\n" + 
				"        </div>\r\n" + 
				"      </div>\r\n" + 
				"    </nav>";
				          
		return header;
	}
}
