package com.mtb.movie.model;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.ticket.model.Ticket;

@Entity
public class Shows {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "show_sequence")
    @GenericGenerator(name="show_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="SH_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String showsId;
	private Date showDate;
	private String startTime;
	private String endTime;
	//@JsonManagedReference
	@OneToMany(mappedBy="show", cascade = CascadeType.ALL)
	private List<ShowSeat> showSeats;
	//@JsonManagedReference
	@OneToMany(mappedBy="shows", cascade = CascadeType.ALL)
	private List<Ticket> tickets;
	//@JsonBackReference
	@ManyToOne
	private Movie movie;
	//@JsonBackReference
	@ManyToOne
	private TheatreScreen theatreScreen;
	

	public String getShowId() {
		return showsId;
	}
	public void setShowId(String showId) {
		this.showsId = showId;
	}
	public Date getShowDate() {
		return showDate;
	}
	public void setShowDate(Date showDate) {
		this.showDate = showDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public Movie getMovie() {
		return movie;
	}
	public void setMovie(Movie movie) {
		this.movie = movie;
	}
	public TheatreScreen getTheatreScreen() {
		return theatreScreen;
	}
	public void setTheatreScreen(TheatreScreen theatreScreen) {
		this.theatreScreen = theatreScreen;
	}
	public List<ShowSeat> getShowSeats() {
		return showSeats;
	}
	public void setShowSeats(List<ShowSeat> showSeats) {
		this.showSeats = showSeats;
	}
	public List<Ticket> getTickets() {
		return tickets;
	}
	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}
}	
