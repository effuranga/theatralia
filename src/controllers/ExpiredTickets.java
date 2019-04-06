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
 * Servlet implementation class ExpiredTickets
 */
@WebServlet("/expiredtickets")
public class ExpiredTickets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Muestra los tickets con fecha de ayer o posterior, NO ENTREGADOS
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//TODO llamar a los tickets pasados y ofrecer cargar en la tarjeta a aquellos que no esten pagos, permitir filtrar
		//TODO por los que no estan pagos y permitir cargar de a uno o en bulk
		
		HttpSession session = request.getSession();
		User loggedUser = (User)session.getAttribute("loggedUser");
		if(loggedUser == null || !loggedUser.isAdmin()) {
			response.sendRedirect("error.jsp?e=Debes iniciar sesion (como Administrador) para poder realizar esta accion.");
			return;
		}
		TicketHandler ticketHandler = new TicketHandler();
		ArrayList<DTODeliveryTable> expiredTableDTOs = new ArrayList<DTODeliveryTable>();
		
		expiredTableDTOs = ticketHandler.getExpiredTableDTOs();
				
		// Export?
		boolean export = (request.getParameter("export") != null && request.getParameter("export").equals("true"));
		if(!export) {
			request.setAttribute("rows", expiredTableDTOs);
			request.getRequestDispatcher("expiredtickets.jsp").forward(request, response);
		}
		else {
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-disposition", "filename=Tickets expirados.xls");
			
			PrintWriter out = response.getWriter();
			try {
				DateHandler dh = new DateHandler();
				out.println("Ticket ID\tObra\tFuncion\tCliente\tPago\tFecha de compra\tTarjeta");
				for(DTODeliveryTable dto : expiredTableDTOs) {
					String ticketId = ""+dto.getTicketId();
					String playName = dto.getPlayName();
					String showDate = dh.getHTMLDate(dto.getShowDate())+" "+dh.getHTMLTime(dto.getShowDate());
					String client = dto.getUserLastName()+", "+dto.getUserName();
					String isPaid = (dto.isPaid())? "Si" : "No";
					String buyingDate = dh.getHTMLDate(dto.getBuyingDate())+" "+dh.getHTMLTime(dto.getBuyingDate());
					String card = dto.getCardNumber();
					
					out.println(ticketId+"\t"+playName+"\t"+showDate+"\t"+client+"\t"+isPaid+"\t"+buyingDate+"\t"+card);
				} 
				
			}
			finally {
				out.close();
			}
		}
	}

}
