package com.mtb.theatre.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.movie.service.MovieService;
import com.mtb.movie.service.ShowService;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.service.TheatreScreenService;
import com.mtb.theatre.service.TheatreService;
import com.mtb.user.exception.ShowExpiredException;
import com.mtb.user.model.User;
import com.mtb.user.model.UserPrincipal;

@Controller
public class TheatreScreenController {

	@Autowired
	private TheatreScreenService screenService;
	
	@Autowired
	private TheatreService theatreService;
	@Autowired
	private ShowService showService;
	@Autowired
	private MovieService movieService;
	
	Logger logger = LoggerFactory.getLogger(TheatreScreenController.class);
	
	
	@RequestMapping("/theatre/addTheatreScreen")
	public ModelAndView addTheatreScreen(ModelAndView md,TheatreScreen theatreScreen, HttpSession ses) {
		//User user = (User)ses.getAttribute("user");
		String theatreId = (String) ses.getAttribute("theatreId");
		Theatre theatre = screenService.addTheatreScreen(theatreId,theatreScreen);
		if(theatre!=null) {
			List<TheatreScreen> theatreScreens = screenService.getAllScreens(theatre);
			md.addObject("theatreScreens", theatreScreens);
			md.addObject("addScreenSuccess", "Screen added successfully").setViewName("viewScreens");
			logger.info("Screen Added Successfully by "+ theatreScreen.getTheatre().getUser().getUserId() );
			return md;
		}
		md.addObject("failed", "Screen cant be added").setViewName("theatreScreen");
		logger.error("Not able to add Screen by userId "+ theatreScreen.getTheatre().getUser().getUserId() );
		return md;
	}
	
	@RequestMapping("/theatre/deleteTheatreScreen")
	public ModelAndView deleteTheatreScreen(HttpSession ses, @RequestParam("screenId") String screenId,ModelAndView md) {
		screenService.deleteScreen(screenId);
		String theatreId = (String) ses.getAttribute("theatreId");
		Theatre theatre = theatreService.getTheatreById(theatreId);
		List<TheatreScreen> theatreScreens = screenService.getAllScreens(theatre);
		md.addObject("theatreScreens", theatreScreens);
		md.addObject("theatre", theatre);
		md.addObject("deleteScreenSuccess", "Screen deleted successfully").setViewName("viewScreens");
		logger.info("Screen deleted Successfully ");
		return md;
	}
	
	@RequestMapping("/theatre/getAllTheatreScreens")
	public ModelAndView getAllTheatreScreens(ModelAndView md,HttpSession ses) {
		String theatreId = (String) ses.getAttribute("theatreId");
		List<TheatreScreen> theatreScreens = screenService.getTheatreScreens(theatreId);
		if(theatreScreens!=null) {
			logger.info("All Screesns Loaded for " + theatreId);
			md.addObject("theatreScreens", theatreScreens).setViewName("theatreScreen");
			return md;
		}
		logger.info("No screens added for" + theatreId);
		md.addObject("failed", "no theatre screens").setViewName("theatreScreen");
		return md;
	}
	
	@RequestMapping("/theatre/updateTheatreScreen")
	public ModelAndView updateTheatreScreen(ModelAndView md,TheatreScreen theatreScreen, HttpSession ses) {
		
		TheatreScreen theatreScreen2 = screenService.updateTheatreScreen(theatreScreen);
		if(theatreScreen2!=null) {
			String theatreId = (String) ses.getAttribute("theatreId");
			Theatre theatre = theatreService.getTheatreById(theatreId);
			List<TheatreScreen> theatreScreens = screenService.getAllScreens(theatre);
			md.addObject("theatreScreens", theatreScreens);
			md.addObject("theatre", theatre);
			md.addObject("updateScreenSuccess", "Screen updated successfully").setViewName("viewScreens");
			logger.info("Screen Updated Successfully by "+ theatreScreen.getTheatre().getUser().getUserId() );
			return md;
		}
		logger.info("Not able to update Screen by userId "+ theatreScreen.getTheatre().getUser().getUserId() );
		return md;
	}
	
	@RequestMapping("/theatre/theatreScreens")
	public ModelAndView theatreScreens(HttpSession ses, @RequestParam("id") String theatreId, ModelAndView md) {
		Theatre theatre = theatreService.getTheatreById(theatreId);
		ses.setAttribute("theatreId", theatreId);
		List<TheatreScreen> theatreScreens = screenService.getAllScreens(theatre);
		md.addObject("theatreScreens", theatreScreens).addObject("theatre", theatre);
		md.setViewName("viewScreens");
		logger.info("Screens loaded for theatreId " + theatreId);
		return md;
	}
	
	@RequestMapping("/getSeatLayout")
	public ModelAndView getSeatLayout(@RequestParam("date") String today, @RequestParam("movieId") String movieId,@RequestParam("showId") String showId,ModelAndView md) {
		Date input = screenService.getFormatedDate(today);
		Shows show = showService.selectShow(showId);
		Movie movie = movieService.selectMovie(movieId);
		
		if (DateUtils.isSameDay(show.getShowDate(), new Date())) {
				
		} else if (show.getShowDate().before(new Date())) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			UserPrincipal principal = (UserPrincipal) auth.getPrincipal();
			User user = principal.getUser();
			logger.error("Show Expired...Trying to access expired movie shows " + user.getUserId());
			throw new ShowExpiredException("404","Show expired");
		}
		
		List<Shows> shows = screenService.getTodayShows(movie, show, input);
		md.addObject("movie", movie);
		md.addObject("date", today);
		md.addObject("singleShow", show);
		md.addObject("shows", shows);
		md.setViewName("userSeatLayout");
		System.out.println("here");
		return md;
	}
	
	@RequestMapping("/theatre/UpdateScreenSeats")
	public ModelAndView UpdateScreenSeats(HttpSession ses, @RequestParam("id") String screenId, ModelAndView md) {
		logger.info("Screen Seats Updated");
		screenService.deleteScreenSeats(screenId);
		return md;
	}
}
