package com.mtb.payment;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.service.ShowSeatService;
import com.mtb.ticket.exception.PaymentFailedException;
import com.mtb.ticket.model.Ticket;
import com.mtb.ticket.repository.TicketRepo;
import com.mtb.ticket.service.TicketService;
import com.paypal.api.payments.Links;

import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

@Controller
public class PaypalController {
	
	@Autowired
	private ShowSeatService showSeatService;
	
	@Autowired
	private TicketService ticketService;
	
	@Autowired
	PaypalService service;
	public static final String SUCCESS_URL = "pay/ticketSuccess";
	public static final String CANCEL_URL = "pay/cancel";
		
	@PostMapping("ticket/pay")	
	public String payment(Ticket ticket, HttpSession ses) 
	{
		ticketService.setTimeStamp(ticket.getTicketId());
		ses.setAttribute("ticket", ticket);
		showSeatService.setSeatStaus(ticket.getTicketId(), "blocked");
		try 
		{	
			Payment payment = service.createPayment(ticket.getTicketId(), ticket.getNumberOfSeats(), 
					ticket.getTotalAmount(), "http://localhost:8080/" + CANCEL_URL,
					"http://localhost:8080/" + SUCCESS_URL);
			for(Links link:payment.getLinks()) 
			{				
				if(link.getRel().equals("approval_url")) 
				{					
					return "redirect:"+link.getHref();
				}			
			}					
		} 
		catch (PayPalRESTException e) 
		{					
			e.printStackTrace();		
		}		
		return "redirect:/";	
	}
	
	@GetMapping(value = CANCEL_URL)
	public void cancelPay() 
	{	 
		throw new PaymentFailedException("401", "Payment Failed");
			 
	} 	 
	@GetMapping(value = SUCCESS_URL)	 
	public ModelAndView successPay(ModelAndView md, HttpSession ses,@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId) 
	{	
		Ticket ticket = (Ticket)ses.getAttribute("ticket");
		ticketService.setTicketStatus(ticket.getTicketId(), "confirmed");
		showSeatService.setSeatStaus(ticket.getTicketId(), "booked");
		ticket = ticketService.getTicketById(ticket.getTicketId());
		try 
		{	 
			Payment payment = service.executePayment(paymentId, payerId);	 
			System.out.println(payment.toJSON());	 
			if (payment.getState().equals("approved")) 
			{	 
				md.addObject("ticket", ticket);
				md.setViewName("ticketSuccess");
				return md;	 
			}	 
		} 
		catch (PayPalRESTException e) 
		{	 
			System.out.println(e.getMessage());	 
		}
		return md;
	}
}
