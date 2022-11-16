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

import com.mtb.movie.model.ShowSeat;
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
public class TheatreSeat {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "tseat_sequence")
    @GenericGenerator(name="tseat_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="tseat_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String id;
	private String seatNumber;
	private String seatType;
	private double price;
	//@JsonBackReference
	@ManyToOne
	private TheatreScreen theatreScreen;
	//@JsonManagedReference
	@OneToMany(mappedBy="theatreSeat", cascade = CascadeType.ALL)
	private List<ShowSeat> showSeats; 
	
	
	
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSeatNumber() {
		return seatNumber;
	}
	public void setSeatNumber(String seatNumber) {
		this.seatNumber = seatNumber;
	}
	public String getSeatType() {
		return seatType;
	}
	public void setSeatType(String seatType) {
		this.seatType = seatType;
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
	
}
