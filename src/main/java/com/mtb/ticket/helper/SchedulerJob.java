package com.mtb.ticket.helper;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.mtb.movie.model.ShowSeat;
import com.mtb.movie.repository.ShowSeatRepo;
import com.mtb.ticket.model.Ticket;
import com.mtb.ticket.repository.TicketRepo;

@Component
public class SchedulerJob {
	
	@Autowired
	private TicketRepo ticketRepo;
	
	@Autowired
	private ShowSeatRepo showSeatRepo;
	
	@Scheduled(fixedDelay = 5000, initialDelay = 5000)
	public void unfreezeSeats() {
		List<Ticket> tickets = ticketRepo.findAll();
		Date currentTime = new Date();
		for(Ticket ticket: tickets) {
			if(ticket.getTimestamp()!=null) {
				if(((currentTime.getTime()-ticket.getTimestamp().getTime())/60000)>1) {
					if(ticket.getStatus().equals("pending")) {
						List<ShowSeat> showSeats = ticket.getShowSeats();
						showSeats.forEach((seat)->{
							
							seat.setStatus("Available");
							showSeatRepo.save(seat);
						});
					}
				}
			}
		}
	}
}
