package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import business.User;
import services.TicketHandler;
import utils.DTOTicketList;
import utils.DateHandler;

/**
 * Servlet implementation class ListTickets
 */
@WebServlet("/listtickets")
public class ListTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como administrador) para poder realizar esta accion.");
			return;
		}
		int showId = 0;
		
		try {
			showId = Integer.parseInt(request.getParameter("showId"));
		}
		catch(NumberFormatException e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp?e=El parametro es invalido");
			return;
		}
		
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTOTicketList> ticketsListDTOs = new ArrayList<DTOTicketList>();
		
		ticketsListDTOs = ticketHandler.getTicketsListDTOs(showId);
		
		// Export?
		boolean export = (request.getParameter("export") != null && request.getParameter("export").equals("true"));
		if(!export) {
			request.setAttribute("ticketslist", ticketsListDTOs);
			request.getRequestDispatcher("ticketslist.jsp").forward(request, response);
		}
		else {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "filename=Lista de Tickets para "+ticketsListDTOs.get(0).getPlayName()+" "+ticketsListDTOs.get(0).getShowDate()+".xls");
			
			PrintWriter out = response.getWriter();
			try {
				DateHandler dh = new DateHandler();
				out.println("Ticket ID\tCliente\tVendedor\tTarjeta\tPago\tDelivery code\tFecha de compra\tCant asientos\tTotal");
				for(DTOTicketList dto : ticketsListDTOs) {
					String ticketId = ""+dto.getTicketId();
					String client = (dto.isClient())? dto.getUserLastName()+", "+dto.getUserName() : "CLIENTE OCASIONAL";
					String sale = (dto.isClient())? "WEB" : dto.getUserLastName()+", "+dto.getUserName();
					String card = (dto.isClient())? dto.getCardNumber() : "N/A";
					String isPaid = (dto.isPaid())? "Si" : "No";
					String deliveryCode = (dto.isClient())? dto.getDeliveryCode() : "N/A";
					String buyDate = dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate());
					String cantSeats = ""+dto.getCantSeats();
					String total = "$ "+dto.getTotal();
					
					out.println(ticketId+"\t"+client+"\t"+sale+"\t"+card+"\t"+isPaid+"\t"+deliveryCode+"\t"+buyDate+"\t"+cantSeats+"\t"+total);
				} 
				
			}
			finally {
				out.close();
			}
		}
	}
}
