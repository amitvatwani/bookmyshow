package com.mtb.theatre.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mtb.movie.model.Shows;
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;

@Entity
public class TheatreScreen {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "screen_sequence")
    @GenericGenerator(name="screen_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="TS_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String screenId;
	private String screenName;
	private int totalSeats;
	//@JsonManagedReference
	@OneToMany(mappedBy="theatreScreen",  cascade = CascadeType.ALL)
	private List<TheatreSeat> theatreSeats;
	//@JsonManagedReference
	@OneToMany(mappedBy="theatreScreen", cascade = CascadeType.ALL)
	private List<Shows> shows;
	//@JsonBackReference
	@ManyToOne
	private Theatre theatre;
	
	
	
	
	public String getScreenId() {
		return screenId;
	}
	public void setScreenId(String screenId) {
		this.screenId = screenId;
	}
	public String getScreenName() {
		return screenName;
	}
	public void setScreenName(String screenName) {
		this.screenName = screenName;
	}
	public int getTotalSeats() {
		return totalSeats;
	}
	public void setTotalSeats(int totalSeats) {
		this.totalSeats = totalSeats;
	}
	public List<TheatreSeat> getTheatreSeats() {
		return theatreSeats;
	}
	public void setTheatreSeats(List<TheatreSeat> theatreSeats) {
		this.theatreSeats = theatreSeats;
	}
	public List<Shows> getShows() {
		return shows;
	}
	public void setShows(List<Shows> shows) {
		this.shows = shows;
	}
	public Theatre getTheatre() {
		return theatre;
	}
	public void setTheatre(Theatre theatre) {
		this.theatre = theatre;
	}
	
}
