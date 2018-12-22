<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="java.util.HashMap"
    import="java.util.ArrayList"
    import="java.util.Collection"
    import="business.Play"
    import="business.Seat"
    import="business.Show"
    import="business.User"
    import="business.Ticket"
    import="services.TicketHandler"
    import="services.PlayHandler"
    
    import ="java.text.SimpleDateFormat"
	import ="java.util.Date"
    %>
<% 

/* TicketHandler th = new TicketHandler(); 
	Ticket ticket = th.retrieveTicket(27);
	out.print(ticket.getCard().getNumber()); 
*/	
	/* PlayHandler ph = new PlayHandler();
	Play p = ph.getWholePlay(46);
	p.removeShowsWithNoSeatsLeft();
	ArrayList<Show> shows = p.getShows();
	for(Show s : shows){
		out.println(s.getId()+" "+s.getDate()+"<br> ");
		out.println(s.hasSeatsAvailable());
		ArrayList<Seat> seats = s.getSeats();
		for(Seat seat : seats){
			out.println("   "+seat.getId()+" "+seat.getStatus()+"<br> ");
		}
	}  */
	/* PlayHandler ph = new PlayHandler();
	Play play = ph.getBasicPlay("37");
	if(play == null) {
		out.print("error.jsp?e=La obra solicitada no existe");
	}
	else {
		ph.fillWithShows(play);
	}	
	 */
	 
	 Date atualDate = new Date();
		
%> 