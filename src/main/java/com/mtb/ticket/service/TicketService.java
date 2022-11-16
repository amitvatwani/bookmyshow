package com.mtb.ticket.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.ticket.model.Ticket;
import com.mtb.ticket.repository.TicketRepo;
import com.mtb.user.model.User;

@Service
public class TicketService {
	
	@Autowired
	private TicketRepo ticketRepo;
	
	public void setTicketStatus(String ticketId, String status)
	{
		Ticket ticket = ticketRepo.findById(ticketId).get();
		ticket.setStatus(status);
		ticketRepo.save(ticket);
	}
	
	public void setTimeStamp(String ticketId)
	{
		Ticket ticket = ticketRepo.findById(ticketId).get();
		ticket.setTimestamp(new Date());
		ticketRepo.save(ticket);
	}
	
	public List<Ticket> viewTickets(User user){
        return ticketRepo.findByUser(user.getUserId());
    }
    
    public List<Ticket> viewAllTickets(User user){
        return ticketRepo.findAll();
    }
    
    public Ticket getTicketById(String ticketId) {
    	return ticketRepo.findById(ticketId).get();
    }
}
