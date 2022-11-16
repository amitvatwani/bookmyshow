package com.mtb.movie.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.Calendar;
import java.util.Date;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.movie.repository.MovieRepository;
import com.mtb.movie.repository.ShowRepository;
import com.mtb.movie.repository.ShowSeatRepo;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.repository.TheatreScreenRepository;

@Service
public class ShowService {

	@Autowired
	private ShowRepository showRepo;
	
	@Autowired
	private ShowSeatService showSeatService;
	
	@Autowired
	private TheatreScreenRepository screenRepo;
	
	@Autowired
	private MovieRepository movieRepo;
	
	public Shows addShow(Dictionary showDetails) {
		Movie movie = movieRepo.findById((String)showDetails.get("movieId")).get();
		TheatreScreen theatreScreen = screenRepo.findById((String) showDetails.get("screenId")).get();
		
		Calendar fromDate = Calendar.getInstance();
		String fullStartDate = (String) showDetails.get("fromDate");
		String[] startDate = fullStartDate.split("-");
		fromDate.set(Integer.parseInt(startDate[0]), Integer.parseInt(startDate[1])-1, Integer.parseInt(startDate[2]));
		
		Calendar toDate = Calendar.getInstance();
		String fullEndDate = (String) showDetails.get("endDate");
		String[] endDate = fullEndDate.split("-");
		toDate.set(Integer.parseInt(endDate[0]), Integer.parseInt(endDate[1])-1, Integer.parseInt(endDate[2]));
		
		while(fromDate.getTime().compareTo(toDate.getTime())<=0) {
			List<LinkedHashMap<String, String>> timings = (List<LinkedHashMap<String, String>>) showDetails.get("timings");
			for(LinkedHashMap time: timings)
			{
				Shows show  =new Shows();
				show.setShowDate(fromDate.getTime());
				show.setStartTime((String)time.get("startTime"));
				show.setEndTime((String)time.get("endTime"));
				show.setMovie(movie);
				show.setTheatreScreen(theatreScreen);
				showRepo.save(show);
				showSeatService.addShowSeat(show);
				
			}
			fromDate.add(Calendar.DATE, 1);
		}
		//return showRepo.save(show);
		return null;
	}
	
	public Shows updateShow(Shows show, String showStringDate) {
		Calendar fromDate = Calendar.getInstance();
		String[] startDate = showStringDate.split("-");
		fromDate.set(Integer.parseInt(startDate[0]), Integer.parseInt(startDate[1])-1, Integer.parseInt(startDate[2]));
		Shows existingShow = showRepo.findById(show.getShowId()).get();
		existingShow.setShowDate(fromDate.getTime());
		existingShow.setStartTime(show.getStartTime());
		existingShow.setEndTime(show.getEndTime());
		return showRepo.save(existingShow);
	}
	
	public boolean deleteShow(String showId) {
		if(showRepo.findById(showId)!=null) {
			showRepo.deleteById(showId);
			return true;
		}
		return false;
	}
	
	public Shows selectShow(String showId) {
		return showRepo.findById(showId).get();
	}
	
	public List<Shows> selectShowByScreen(String screenId) {
		TheatreScreen screen= screenRepo.findById(screenId).get();
		return screen.getShows(); 
	}
	
	public List<Shows> allShowsForAMovie(String movieId){
		Movie movie=movieRepo.findById(movieId).get();
		return showRepo.findByMovie(movie);
	}
}
