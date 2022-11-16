package com.mtb.ticket.model;

import java.util.Date;
import java.util.List;
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
import com.mtb.movie.model.ShowSeat;
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;
import com.mtb.user.model.User;

@Entity
public class Ticket {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "ticket_sequence")
    @GenericGenerator(name="ticket_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="TK_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String ticketId;
	private int numberOfSeats;
	private Date timestamp;
	private String status;
	private double totalAmount;
	//@JsonManagedReference
	@OneToMany(mappedBy="ticket", fetch = FetchType.EAGER)
	private List<ShowSeat> showSeats;
	
	//@JsonBackReference
	@ManyToOne
	private Shows shows;
	//@JsonBackReference
	@ManyToOne
	private User user;
	
	
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	
	public String getTicketId() {
		return ticketId;
	}
	public void setTicketId(String ticketId) {
		this.ticketId = ticketId;
	}
	public int getNumberOfSeats() {
		return numberOfSeats;
	}
	public void setNumberOfSeats(int numberOfSeats) {
		this.numberOfSeats = numberOfSeats;
	}
	public Date getTimestamp() {
		return timestamp;
	}
	public void setTimestamp(Date timestamp) {
		this.timestamp = timestamp;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public Shows getShows() {
		return shows;
	}
	public void setShows(Shows shows) {
		this.shows = shows;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<ShowSeat> getShowSeats() {
		return showSeats;
	}
	public void setShowSeats(List<ShowSeat> showSeats) {
		this.showSeats = showSeats;
	}
}
