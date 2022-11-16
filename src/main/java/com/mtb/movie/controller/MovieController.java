package com.mtb.movie.controller;

import java.util.Collections;
import java.util.List;

import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.model.Movie;
import com.mtb.movie.service.MovieService;
import com.mtb.theatre.controller.TheatreController;
import com.mtb.user.model.User;

@Controller
@RequestMapping("/admin")
public class MovieController {

	
	@Autowired
	private MovieService movieService;
	
	Logger logger = LoggerFactory.getLogger(TheatreController.class);
	
	@RequestMapping("addMoviePage")
	public String addMoviePage(Movie movie,Model m) {
		m.addAttribute("Movie", movie);
		return "addMovie";
	}
	@RequestMapping("showRunningMovies")
	public ModelAndView showRunningMovies(ModelAndView md) {
		return md;
	}
	
	@RequestMapping("addMovie")
	public ModelAndView addMovie(@Valid @ModelAttribute("Movie") Movie movie, BindingResult br, ModelAndView md) {
		
		if (br.hasErrors()) {
            md.setViewName("addMovie");
            logger.warn("Check Validations");
        }
		else if(movieService.addMovie(movie)!=null) {
			logger.info("Movie added successfully");
			md.addObject("movieSuccess", "Movie added successfully").setViewName("adminHome");
			
		}else {
			logger.error("Movie is not added");
			md.addObject("movieFailure", "Movie is not added").setViewName("adminHome");
			
		}
		return md;
	}
	@RequestMapping("updateMoviePage")
	public ModelAndView updateMoviePage(@RequestParam("movieId") String movieId, ModelAndView md) {
		Movie movie=movieService.selectMovie(movieId);
		md.addObject("movie",movie).setViewName("updateMovie");
		return md;
	}
	
	@RequestMapping("updateMovie")
	public ModelAndView updateMovie(Movie movie, ModelAndView md) {
		Movie m1=movieService.updateMovie(movie);
		if(m1!=null) {
		md.addObject("movieSuccess","Movie updated successfully").setViewName("adminHome");
		logger.info("Movie updated successfully");
		}
		else {
			logger.error("Movie updation failed");
			md.addObject("movieFailure","Movie updation failed").setViewName("adminHome");
		}
		return md;
	}
	
	@RequestMapping("deleteMovie")
	public ModelAndView deleteMovie(@RequestParam("movieId") String movieId, ModelAndView md) {
		if(movieService.deleteMovie(movieId)) {
			md.addObject("movieSuccess","Movie deleted successfully").setViewName("adminHome");
			logger.info("Movie deleted successfully");
			return md;
		}else {
			md.addObject("movieFailure","Movie deletion failed ").setViewName("adminHome");
			logger.error("Movie deletion failed");
			return md;
		}
			
	}
	
	@RequestMapping("selectMovie")
	public ModelAndView selectMovie(@RequestParam("movieId") String movieId, ModelAndView md) {
		Movie movie=movieService.selectMovie(movieId);
		if(movie !=null) {
			md.addObject("movie",movie).setViewName("viewMovie");
			logger.info("viewing movie " + movieId );
			return md;
		}
		else {
			logger.error("Movie is not available " );
			md.addObject("Failure","Movie is not available").setViewName("selectMovie");
			return md;
		}
	}
	
	@RequestMapping("showMovies")
	public ModelAndView showMovies(ModelAndView md) {
		List<Movie> movies=movieService.showAllMovies();
		Collections.reverse(movies);
		md.addObject("movies",movies).setViewName("viewMovies");
		logger.info("viewing all movies to admin" );
		return md;
		
	}
}










