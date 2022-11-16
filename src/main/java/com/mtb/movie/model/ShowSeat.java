package com.mtb.movie.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;
import com.mtb.theatre.model.TheatreSeat;
import com.mtb.ticket.model.Ticket;


@Entity
public class ShowSeat {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "show_seat_sequence")
    @GenericGenerator(name="show_seat_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="SS_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String seatId;
	private String status;
	//@JsonBackReference
	@ManyToOne
	private TheatreSeat theatreSeat;
	//@JsonBackReference
	@ManyToOne
	private Shows show;
	//@JsonBackReference
	@JsonIgnore
	@ManyToOne
	private Ticket ticket;
	
	
	public String getSeatId() {
		return seatId;
	}
	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public TheatreSeat getTheatreSeat() {
		return theatreSeat;
	}
	public void setTheatreSeat(TheatreSeat theatreSeat) {
		this.theatreSeat = theatreSeat;
	}
	public Shows getShow() {
		return show;
	}
	public void setShow(Shows show) {
		this.show = show;
	}
	public Ticket getTicket() {
		return ticket;
	}
	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}
}
