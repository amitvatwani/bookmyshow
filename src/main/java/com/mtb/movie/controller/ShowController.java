package com.mtb.movie.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.movie.service.MovieService;
import com.mtb.movie.service.ShowService;
import com.mtb.theatre.controller.TheatreController;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.service.TheatreScreenService;
import com.mtb.user.model.User;

@Controller
public class ShowController {

	@Autowired
	private ShowService showService;
	
	@Autowired
	private MovieService movieService;
	
	@Autowired
	private TheatreScreenService screenService;
	
	Logger logger = LoggerFactory.getLogger(TheatreController.class); 
	
	@RequestMapping(path="/theatre/addShow", consumes= {"application/json"})
	public ModelAndView addShow(@RequestBody Hashtable showDetails,ModelAndView md,HttpSession sess) {
		showService.addShow(showDetails);
		User user =(User) sess.getAttribute("user");
		logger.info("show Added By "+user.getUserId());
		return md;
		
		
	}
	
	@RequestMapping("theatre/updateShow")
	public ModelAndView updateShow(@RequestParam("screenId") String screenId,@RequestParam("showStringDate") 
	String showStringDate,Shows show,ModelAndView md,HttpSession sess) {
		User user =(User) sess.getAttribute("user");
		if(showService.updateShow(show, showStringDate)!=null) {
			List<Movie> movies = movieService.getMovie();
			TheatreScreen screen=screenService.getTheatreScreenById(screenId);
			md.addObject("movies",movies);
			md.addObject("screen", screen);
			List<Shows> shows=showService.selectShowByScreen(screenId);
			md.addObject("shows", shows);
			md.addObject("updateShowSuccess", "Show updated Successfully").setViewName("viewShows");
			
			logger.info("Show Updated successfully by "+user.getUserId());
		}
		else {
			logger.error("Show has not updated"+user.getUserId());
			md.addObject("showFailure","Show has not updated").setViewName("theatreHome");
		}
		return md;
	}
	
	@RequestMapping("/theatre/deleteShow")
	public ModelAndView deleteShow(@RequestParam("showId") String showId,@RequestParam("screenId") 
	String screenId,ModelAndView md,HttpSession sess) {
		User user =(User) sess.getAttribute("user");
		if(showService.deleteShow(showId)) {
			List<Movie> movies = movieService.getMovie();
			TheatreScreen screen=screenService.getTheatreScreenById(screenId);
			md.addObject("movies",movies);
			md.addObject("screen", screen);
			List<Shows> shows=showService.selectShowByScreen(screenId);
			md.addObject("shows", shows);
			md.addObject("deleteShowSuccess", "Show deleted Successfully").setViewName("viewShows");
			logger.info("Show deleted successfully by "+user.getUserId());
			return md;
		}
		else{
			logger.error("Show has not deleted "+user.getUserId());
			md.addObject("showFailure","Show has not deleted").setViewName("theatreHome");
		}
		return md;
	}
	
	@RequestMapping("selectShow")
	public ModelAndView selectShow(@RequestParam("showId") String showId,ModelAndView md) {
		Shows show=showService.selectShow(showId);
		if(show!=null) {
			md.addObject("show",show).setViewName("viewShow");
			logger.info("viewing show " + showId );
			return md;	
		}
		else {md.addObject("showFailure","Not able to select the show").setViewName("theatreHome");
		logger.error("show is not available " );
		}return md;
	}
	
	@RequestMapping("selectShowsOfMovie")
	public ModelAndView selectShowsOfMovie(@RequestParam("movieId") String movieId,ModelAndView md) {
		List<Shows> shows=showService.allShowsForAMovie(movieId);
		if(shows!=null) {
			logger.info("viewing shows for the movie "+movieId);
			md.addObject("shows",shows).setViewName("viewMovieShows");
			return md;	
		}else {
			logger.error("No shows are available for this movie");
		md.addObject("showFailure","No shows are available for this movie").setViewName("theatreHome");
		}return md;
	}
	
	@RequestMapping("/theatre/createShowPage")
	public ModelAndView getShowsByScreen(@RequestParam("id") String screenId,ModelAndView md) {
		List<Movie> movies = movieService.getMovie();
		TheatreScreen screen=screenService.getTheatreScreenById(screenId);
		md.addObject("movies",movies);
		md.addObject("screen", screen);
		List<Shows> shows=showService.selectShowByScreen(screenId);
		if(shows!=null) {
			md.addObject("shows",shows).setViewName("viewShows");
			return md;	
		}
		md.addObject("showFailure","Not able to select the show").setViewName("ownerHome");
		return md;
	}
	
	@RequestMapping("/theatre/displayShowPage")
	public ModelAndView displayShowsByScreen(@RequestParam("screenId") String screenId,ModelAndView md) {
		List<Movie> movies = movieService.getMovie();
		TheatreScreen screen=screenService.getTheatreScreenById(screenId);
		md.addObject("movies",movies);
		md.addObject("screen", screen);
		List<Shows> shows=showService.selectShowByScreen(screenId);
		if(shows!=null) {
			md.addObject("addShowSuccess", "Show added Successfully");
			md.addObject("shows",shows).setViewName("viewShows");
			return md;	
		}
		md.addObject("showFailure","Not able to select the show").setViewName("ownerHome");
		return md;
	}
	
}
