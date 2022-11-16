package com.mtb.ticket.exception;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.movie.service.MovieService;
import com.mtb.movie.service.ShowService;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.service.TheatreCityService;
import com.mtb.ticket.model.Ticket;
import com.mtb.user.exception.UserNotFoundException;

@ControllerAdvice
public class TicketExceptionHandler {
	
	@Autowired
	private  TheatreCityService theatreCityService;
	
	@Autowired
	private ShowService showService;
	
	@Autowired
	private MovieService movieService;
	
	@ExceptionHandler(SeatAlreadyBookedException.class)
    public String handleSeatAlreadyBookedException(SeatAlreadyBookedException seatAlreadyBookedException, Model md, HttpServletRequest request){
		String today = (String)request.getAttribute("date");
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
		String showId = (String)request.getAttribute("showId");
		Shows show = showService.selectShow(showId);
		System.out.println(showId);
		String movieId = (String)request.getAttribute("movieId");
		Movie movie = movieService.selectMovie(movieId);
		
		

		LocalDate date = input.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			List<Shows> shows = new ArrayList<Shows>();
			movie.getShows().forEach((e)->{
				if((e.getTheatreScreen().getTheatre().getTheatreId()==show.getTheatreScreen().getTheatre().getTheatreId())) {
					Date input2 = e.getShowDate();
					LocalDate date2 = input2.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
					if(date.compareTo(date2)==0) {
						shows.add(e);
					}
				}
			});
			HashMap<String, Object> map = new HashMap<>();
			map.put("date", today);
			map.put("singleShow", show);
			map.put("shows", shows);
			md.addAttribute("seatsBooked", seatAlreadyBookedException.getErrorMessage());
			md.mergeAttributes(map);
			return "userSeatLayout";
    }
	
	@ExceptionHandler(PaymentFailedException.class)
	public String handlePaymentFailedException(PaymentFailedException paymentFailedException, Model md, HttpSession ses) {
		
		md.addAttribute("message", paymentFailedException.getErrorMessage());
		return "cancel";
	}
}
