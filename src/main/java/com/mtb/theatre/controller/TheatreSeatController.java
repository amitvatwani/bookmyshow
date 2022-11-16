package com.mtb.theatre.controller;

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

import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.model.TheatreSeat;
import com.mtb.theatre.service.TheatreScreenService;
import com.mtb.theatre.service.TheatreSeatService;

@Controller
public class TheatreSeatController {

	@Autowired
	private TheatreSeatService seatService;
	@Autowired
	private TheatreScreenService screenService;
	Logger logger = LoggerFactory.getLogger(TheatreSeatController.class);

	@RequestMapping("/theatre/createSeatMapPage")
	public ModelAndView createSeatMapPage(HttpSession ses, ModelAndView md, @RequestParam("id") String screenId) {
		TheatreScreen screen = screenService.getTheatreScreenById(screenId);
		ses.setAttribute("screenId", screenId);
		List<TheatreSeat> theatreSeats = seatService.getTheatreSeats(screenId);
		md.addObject("theatreSeats", theatreSeats);
		md.addObject("screen", screen);
		md.setViewName("seatLayout");
		logger.info("Redirecting to  theatrescreen seatLayout for screenId:" + screenId);
		return md;
	}

	@RequestMapping("theatre/addTheatreSeats")
	public ModelAndView addTheatreSeats(@RequestBody List<TheatreSeat> theatreSeat, ModelAndView md, HttpSession ses) {
		String theatreScreenId = (String) ses.getAttribute("screenId");
		List<TheatreSeat> seats = seatService.addTheatreSeat(theatreScreenId, theatreSeat);
		if (seats != null) {
			md.addObject("success", "seat added successfully").setViewName("addSeat");
			logger.info("seat added successfully for theatreScreenId " + theatreScreenId);
			return md;
		}
		logger.error("seat not added for theatreScreenId" + theatreScreenId);
		md.addObject("failed", "seat not added").setViewName("addSeat");
		md.setViewName("ownerHome");
		return md;
	}

	@RequestMapping("/deleteTheatreSeat")
	public ModelAndView deleteTheatreSeat(@RequestParam("seatId") String seatId, ModelAndView md) {
		seatService.deleteSeat(seatId);
		md.addObject("Success", "Seat deleted successfully").setViewName("theatreSeat");
		logger.info("Seat deleted successfully " + seatId);
		return md;
	}

	@RequestMapping("/getAllTheatreSeats")
	public ModelAndView getAllTheatreSeats(ModelAndView md, HttpSession ses) {
		String screenId = (String) ses.getAttribute("screenId");
		List<TheatreSeat> theatreSeats = seatService.getTheatreSeats(screenId);
		System.out.println(theatreSeats);
		if (theatreSeats != null) {
			md.addObject("theatreSeats", theatreSeats).setViewName("theatreSeat");
			logger.info("All seats loaded in theareSeat");
			return md;
		}
		md.addObject("failed", "no theatre seats").setViewName("theatreSeat");
		logger.warn("no theatre seats for screen "+ screenId);
		return md;
	}

	@RequestMapping("/updateTheatreSeat")
	public ModelAndView updateTheatreSeat(ModelAndView md, TheatreSeat theatreSeat, HttpSession ses) {

		TheatreSeat theatreSeat2 = seatService.updateTheatreSeat(theatreSeat);
		if (theatreSeat2 != null) {
			md.addObject("success", "Seat updated successfully").setViewName("theatreSeat");
			logger.info("Seat updated successfully by userId " +theatreSeat.getTheatreScreen().getTheatre().getUser().getUserId());
			return md;
		}
		md.addObject("failed", "Seat not updated").setViewName("theatreSeat");
		logger.warn("Seat not updated by userId "+theatreSeat.getTheatreScreen().getTheatre().getUser().getUserId());
		return md;
	}

}
