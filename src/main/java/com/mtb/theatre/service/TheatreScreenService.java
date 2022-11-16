package com.mtb.theatre.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.model.TheatreSeat;
import com.mtb.theatre.repository.TheatreRepository;
import com.mtb.theatre.repository.TheatreScreenRepository;
import com.mtb.theatre.repository.TheatreSeatRepository;

@Service
public class TheatreScreenService {

	@Autowired
	private TheatreScreenRepository screenRepo;
	@Autowired
	private TheatreRepository theatreRepo;
	@Autowired
	private TheatreSeatRepository seatRepo;

	public Theatre addTheatreScreen(String theatreId, TheatreScreen theatreScreen) {
		// TODO Auto-generated method stub
		Theatre theatre = theatreRepo.findById(theatreId).orElse(null);
		if(theatre!=null) {
			theatre.getTheatreScreens().add(theatreScreen);
			theatreScreen.setTheatre(theatre);
			screenRepo.save(theatreScreen);
			return theatre;
			
		}
		return null;
	}

	public void deleteScreen(String screenId) {
		// TODO Auto-generated method stub
		screenRepo.deleteById(screenId);
	}

	public List<TheatreScreen> getTheatreScreens(String theatreId) {
		// TODO Auto-generated method stub
		Theatre theatre = theatreRepo.findById(theatreId).orElse(null);
		if(theatre!=null) {
			return theatre.getTheatreScreens();
		}
		return null;
	}

	public TheatreScreen updateTheatreScreen(TheatreScreen theatreScreen) {
		// TODO Auto-generated method stub
		TheatreScreen screenFromDatabase = screenRepo.findById(theatreScreen.getScreenId()).orElse(null);
		if(screenFromDatabase!=null) {
			screenFromDatabase.setScreenName(theatreScreen.getScreenName());
			screenFromDatabase.setTotalSeats(theatreScreen.getTotalSeats());
			return screenRepo.save(screenFromDatabase);
		}
		return null;
	}
	
	public List<TheatreScreen> getAllScreens(Theatre theatre){
		return theatre.getTheatreScreens();
	}
	
	public TheatreScreen getTheatreScreenById(String screenId) {
		return screenRepo.findById(screenId).get();
	}
	@Transactional
	public void deleteScreenSeats(String screenId) {
		System.out.println(screenId);
		TheatreScreen screen = screenRepo.findById(screenId).get();
		System.out.println(screen);
		System.out.println(screen.getTheatreSeats());
		seatRepo.deleteAllInBatch(screen.getTheatreSeats());
		System.out.println(screen.getTheatreSeats());
	}
	
	public Date getFormatedDate(String today) {
		SimpleDateFormat formatter=new SimpleDateFormat("dd-MMM-yyyy");
		 String dateArray[] = today.split(" ");
		 String todaysDate = dateArray[2]+"-"+dateArray[1]+"-"+dateArray[5];
		 Date input=null;
		 try {
			input=formatter.parse(todaysDate);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} 
		return input;
	}
	
	public List<Shows> getTodayShows(Movie movie, Shows show, Date input){
		List<Shows> shows= new ArrayList<>();
		LocalDate date = input.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		movie.getShows().forEach((e)->{
			if((e.getTheatreScreen().getTheatre().getTheatreId()==show.getTheatreScreen().getTheatre().getTheatreId())) {
				Date input2 = e.getShowDate();
				LocalDate date2 = input2.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				if(date.compareTo(date2)==0) {
					shows.add(e);
				}
			}
		});
		return shows;
	}
	
}
