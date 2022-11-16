package com.mtb.ticket.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.model.ShowSeat;
import com.mtb.movie.repository.ShowSeatRepo;
import com.mtb.ticket.exception.SeatAlreadyBookedException;
import com.mtb.ticket.model.Ticket;
import com.mtb.ticket.repository.TicketRepo;
import com.mtb.ticket.service.TicketService;
import com.mtb.user.model.User;

@Controller

public class TicketController {
	
	Logger logger = LoggerFactory.getLogger(TicketController.class);
	@RequestMapping("logMappingTicket")
	public String logMapping() {
		logger.trace("trace");
		logger.debug("debug");
		logger.warn("warn");
		logger.error("error");
		return "Welcome to logs";
	}
	
	@Autowired 
	private ShowSeatRepo showSeatRepo;
	@Autowired
	private TicketService ticketService;
	
	@Autowired 
	private TicketRepo ticketRepo;
	
	@RequestMapping("/ticket/bookTicket")
	public ModelAndView bookTicket(@RequestBody List<String> showSeats,Ticket ticket, ModelAndView md, HttpSession ses) {
		User user = (User)ses.getAttribute("user");
		ticket.setUser(user);
		ticket.setShowSeats(showSeatRepo.findAllById(showSeats));
		double amount=0;
		for(ShowSeat seat: ticket.getShowSeats()) {
			if(seat.getStatus().equals("Available")) {
				amount += seat.getTheatreSeat().getPrice(); 
				seat.setTicket(ticket);
			}
			else {
				logger.warn("Seats Already Booked" +seat.getSeatId());
				throw new SeatAlreadyBookedException("601", "Seats Already Booked");
			}
		}
		
		ticket.setShows(ticket.getShowSeats().get(0).getShow());
		ticket.setTotalAmount(amount);
		ticket.setNumberOfSeats(ticket.getShowSeats().size());
		ticket.setStatus("pending");
		ticketRepo.save(ticket);
		showSeatRepo.saveAll(ticket.getShowSeats());
		//ShowService.findShow((ticket.getShow().getShowId()))
		
		ses.setAttribute("ticket", ticket);
		md.addObject("ticket", ticket);
		logger.info("Seat Selected");
		md.setViewName("bookTicket");
		return md;
	}
	
	@RequestMapping("/ticket/showTicketPage")
	public ModelAndView bookTicket(@RequestParam(name = "movieId", required=false) String movieId,
			@RequestParam(name = "showId", required=false) String showId,
			@RequestParam(name = "date", required=false) String today,
			ModelAndView md, HttpSession ses, HttpServletRequest request) {
		System.out.println(movieId + "Hello");
		Ticket ticket = (Ticket)ses.getAttribute("ticket");
		System.out.println(movieId+ "123");
		System.out.println(showId+ "123");
		System.out.println(today + "123");
		if(ticket!=null) {
			md.addObject("ticket", ticket);
			md.setViewName("bookTicket");
		}
		else {
			request.setAttribute("movieId", movieId);
			request.setAttribute("showId", showId);
			request.setAttribute("date", today);
			User user=(User) ses.getAttribute("user");
			logger.warn("Seats Already Booked "+user.getUserId());
			throw new SeatAlreadyBookedException("601", "Seats Already Booked");
		}
		return md;
	}
	
	@RequestMapping("/viewTicketsByUser")
    public ModelAndView viewTickets(ModelAndView md, HttpSession ses) {
        User user=(User) ses.getAttribute("user");
        List<Ticket> tickets= ticketService.viewTickets(user);
        md.addObject("tickets",tickets).setViewName("viewTicketsByUser");
        logger.info("Viewing Tickets By user"+user.getUserId());
        return md;
    }
}
