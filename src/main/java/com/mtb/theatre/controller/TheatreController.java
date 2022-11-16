package com.mtb.theatre.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.service.TheatreCityService;
import com.mtb.theatre.service.TheatreService;
import com.mtb.user.model.User;


@Controller
@RequestMapping("theatre")
public class TheatreController {

	@Autowired
	private TheatreService theatreService;
	@Autowired 
	private TheatreCityService  theatreCityService;
	Logger logger = LoggerFactory.getLogger(TheatreController.class);
	
	@RequestMapping("theatreForm")
    public ModelAndView theatreForm(ModelAndView md){
        List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
        md.setViewName("addTheatre");
        logger.info("Redirecting to addTheatre page");
        return md;
    }



   @RequestMapping("addTheatre")
    public ModelAndView addTheatres(ModelAndView md, HttpSession ses, @RequestParam("theatreName") String theatreName, @RequestParam("theatreCity") String theatreCity){
        User user = (User) ses.getAttribute("user");
        List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
        Theatre theatre=theatreService.addTheatre(theatreName,theatreCity,user);
        md.addObject("theatreRequestSuccess", "Your request has been received");
        List<Theatre> theatres = theatreService.getAllTheatresByUser(user.getUserId());
		md.addObject("theatres",theatres);
//		Set<Movie> movies=new HashSet<Movie>();
//		for(Theatre t:theatres) {
//			for(TheatreScreen ts:t.getTheatreScreens()) {
//				for(Shows sh:ts.getShows()) {
//					movies.add(sh.getMovie());
//				}
//			}
//		}
		md.addObject("firstLocation", true);
//        /md.addObject("movies",movies);
		logger.info("Theatre is added "+theatre.getTheatreId());
		if(user.getUserRole().equals("ROLE_THEATREOWNER")) {
			md.setViewName("viewTheatresByUser");
			}
		else
			md.setViewName("index");
        return md;
    }
   
   @RequestMapping("addNewTheatre")
   public ModelAndView addNewTheatre(ModelAndView md, HttpSession ses, @RequestParam("theatreName") String theatreName, @RequestParam("theatreCity") String theatreCity){
       User user = (User) ses.getAttribute("user");
       List<TheatreCity> theatreCities=theatreCityService.getAllCities();
       md.addObject("theatreCity", theatreCities);
       Theatre theatre=theatreService.addTheatre(theatreName,theatreCity,user);
       md.addObject("theatreRequestSuccess", "Your request has been received");
       List<Theatre> theatres=theatreCities.get(0).getTheatres();
		md.addObject("theatres",theatres);
		Set<Movie> movies=new HashSet<Movie>();
		for(Theatre t:theatres) {
			if(t.getTheatreScreens()!=null) {
				for(TheatreScreen ts:t.getTheatreScreens()) {
					for(Shows sh:ts.getShows()) {
						movies.add(sh.getMovie());
					}
				}
			}
		}
	   md.addObject("firstLocation", true);
       md.addObject("movies",movies);
       logger.info("Theatre is added "+theatre.getTheatreId());
       if(user.getUserRole().equals("ROLE_THEATREOWNER"))
    	  md.setViewName("viewTheatresByUser");
       else
    	  md.setViewName("redirect:/index");
       return md;
   }
	
//	@RequestMapping("addTheatre")
//	public ModelAndView addTheatre(Theatre theatre) {
//		Theatre t=theatreService.addTheatre(theatre);
//		return null;
//	}
	
	@RequestMapping("deleteTheatre")
	public ModelAndView deleteTheatre(HttpSession ses, ModelAndView md, @RequestParam("theatreId") String id) {
		boolean t=theatreService.deleteTheatre(id);
		List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
		User user = (User)ses.getAttribute("user");
		List<Theatre> theatres = theatreService.getAllTheatresByUser(user.getUserId());
		md.addObject("theatres",theatres);
		md.addObject("theatreDeleteSuccess", "Theatre Deleted Successfully");
		md.setViewName("viewTheatresByUser");
		if(t) {
			logger.info("Theatre deleted Successfully "+id);
		}
		return md;
	}
	
	@RequestMapping("updateTheatre")
	public ModelAndView updateTheatre(HttpSession ses, ModelAndView md, @RequestParam("theatreId") String theatreId,@RequestParam("theatreName") String theatreName, @RequestParam("theatreCity") String theatreCity) {
		boolean t=theatreService.updateTheatre(theatreId, theatreName, theatreCity);
		User user = (User)ses.getAttribute("user");
		List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
		List<Theatre> theatres = theatreService.getAllTheatresByUser(user.getUserId());
		md.addObject("theatres",theatres);
		md.addObject("theatreUpdateSuccess", "Theatre Updated Successfully");
		md.setViewName("viewTheatresByUser");
		if(t) {
			logger.info("Theatre Updated Successfully:"+ theatreId);
		}else {
			logger.warn("Theatre not Updated "+ theatreId);
		}
		return md;
	}
	
	
	@RequestMapping("getAllTheatres")
    public ModelAndView getAllTheatres(ModelAndView md,HttpSession ses){
		List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
        User user = (User) ses.getAttribute("user");
        List<Theatre> theatres=theatreService.getAllTheatresByUser(user.getUserId());
        md.addObject("theatres",theatres);
        md.setViewName("viewTheatresByUser");
        logger.info("Refirecting to viewTheatreByUser");
        return md;
    }
	
	@RequestMapping("getTheatreById")
	public ModelAndView getTheatreById(String id) {
		Theatre t=theatreService.getTheatreById(id);
		return null;
	}
}
