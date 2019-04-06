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
import utils.DTODeliveryTable;
import utils.DateHandler;

/**
 * Servlet implementation class Delivery
 */
@WebServlet("/delivery")
public class Delivery extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Para la entrega de tickets (y opcionalmente cobrar) SOLO PARA TICKETS DE HOY EN ADELANTE
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || loggedUser.isClient()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como empleado o administrador) para poder realizar esta accion.");
			return;
		}
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTODeliveryTable> deliveryTableDTOs = new ArrayList<DTODeliveryTable>();
		
		deliveryTableDTOs = ticketHandler.getDeliveryTableDTOs();
		
		// Export?
		boolean export = (request.getParameter("export") != null && request.getParameter("export").equals("true"));
		if(!export) {
			request.setAttribute("rows", deliveryTableDTOs);
			request.getRequestDispatcher("delivery.jsp").forward(request, response);
		}
		else {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "filename=Tickets delivery.xls");
			
			PrintWriter out = response.getWriter();
			try {
				DateHandler dh = new DateHandler();
				out.println("Ticket ID\tObra\tFuncion\tCliente\tTarjeta\tPago\tDelivery code\tFecha de compra");
				for(DTODeliveryTable dto : deliveryTableDTOs) {
					String ticketId = ""+dto.getTicketId();
					String playName = dto.getPlayName();
					String showDate = dh.getHTMLDate(dto.getShowDate())+" "+dh.getHTMLTime(dto.getShowDate());
					String client = dto.getUserLastName()+", "+dto.getUserName();
					String card = dto.getCardNumber();
					String isPaid = (dto.isPaid())? "Si" : "No";
					String deliveryCode = dto.getDeliveryCode();
					String buyingDate = dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate());
					
					out.println(ticketId+"\t"+playName+"\t"+showDate+"\t"+client+"\t"+card+"\t"+isPaid+"\t"+deliveryCode+"\t"+buyingDate);
				} 
				
			}
			finally {
				out.close();
			}
		}
	}

}
