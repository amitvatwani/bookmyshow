package com.mtb.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.movie.model.ShowSeat;
import com.mtb.movie.model.Shows;
import com.mtb.movie.repository.ShowSeatRepo;
import com.mtb.theatre.model.TheatreSeat;

@Service
public class ShowSeatService {
	
	@Autowired
	private ShowSeatRepo showSeatRepo;

	public void addShowSeat(Shows show) {
		List<TheatreSeat> seats = show.getTheatreScreen().getTheatreSeats();
		for(TheatreSeat seat: seats) {
			ShowSeat showSeat=new ShowSeat();
			showSeat.setTheatreSeat(seat);
			showSeat.setShow(show);
			showSeat.setStatus("Available");
			showSeatRepo.save(showSeat);
		}
		
	}
	
	public void setSeatStaus(String ticketId, String status)
	{
		int res = showSeatRepo.updateSeatStatus(status, ticketId);
	}
}
