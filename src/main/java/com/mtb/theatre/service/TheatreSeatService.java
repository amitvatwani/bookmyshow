package com.mtb.theatre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.model.TheatreSeat;
import com.mtb.theatre.repository.TheatreScreenRepository;
import com.mtb.theatre.repository.TheatreSeatRepository;

@Service
public class TheatreSeatService {

	@Autowired
	private TheatreSeatRepository seatRepo;
	@Autowired 
	private TheatreScreenRepository screenRepo;
	
	public List<TheatreSeat> addTheatreSeat(String theatreScreenId, List<TheatreSeat> theatreSeat) {
		// TODO Auto-generated method stub
		TheatreScreen theatreScreen = screenRepo.findById(theatreScreenId).orElse(null);
		if(theatreScreen!=null) {
			for(TheatreSeat ts: theatreSeat) {
				ts.setTheatreScreen(theatreScreen);
				seatRepo.save(ts);
			}
			//theatreScreen.getTheatreSeats().add(theatreSeat);
			//theatreSeat.setTheatreScreen(theatreScreen);
			//seatRepo.saveAll(theatreSeat);
			//screenRepo.save(theatreScreen);
			return theatreSeat;
		}
		
		
		return null;
	}

	public void deleteSeat(String seatId) {
		// TODO Auto-generated method stub
		seatRepo.deleteById(seatId);
	}

	public List<TheatreSeat> getTheatreSeats(String screenId) {
		// TODO Auto-generated method stub
		TheatreScreen theatreScreen = screenRepo.findById(screenId).orElse(null);
		if(theatreScreen!=null) {
			return theatreScreen.getTheatreSeats();
		}
		return null;
	}

	public TheatreSeat updateTheatreSeat(TheatreSeat theatreSeat) {
		// TODO Auto-generated method stub
		TheatreSeat seatFromDatabase = seatRepo.findById(theatreSeat.getId()).orElse(null);
		if(seatFromDatabase!=null) {
			seatFromDatabase.setSeatType(theatreSeat.getSeatType());
			
			return seatRepo.save(seatFromDatabase);
		}
		return null;
	}

}
