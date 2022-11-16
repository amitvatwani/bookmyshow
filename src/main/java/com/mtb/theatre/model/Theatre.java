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
import com.mtb.sequence.StringPrefixedSequenceIdGenerator;
import com.mtb.user.model.User;

@Entity
public class Theatre {
	@Id
	@GeneratedValue(strategy =GenerationType.SEQUENCE,generator = "theatre_sequence")
    @GenericGenerator(name="theatre_sequence",
            strategy = "com.mtb.sequence.StringPrefixedSequenceIdGenerator",
            parameters = {
                    @Parameter(name=StringPrefixedSequenceIdGenerator.INCREMENT_PARAM,value="1"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.VALUE_PREFIX_PARAMETER,value="TR_"),
                    @Parameter(name=StringPrefixedSequenceIdGenerator.NUMBER_FORMAT_PARAMETER,value="%04d")
            }
            )
	private String theatreId;
	
	private String theatreName;
	//@JsonBackReference
	@ManyToOne
	private User user;
	//@JsonBackReference
	@ManyToOne
	private TheatreCity theatreCity;
	//@JsonManagedReference
	@OneToMany(mappedBy="theatre",  cascade = CascadeType.ALL)
	private List<TheatreScreen> theatreScreens;
	private boolean theatreApproval;
	
	
	public String getTheatreId() {
		return theatreId;
	}
	public void setTheatreId(String theatreId) {
		this.theatreId = theatreId;
	}
	public String getTheatreName() {
		return theatreName;
	}
	public void setTheatreName(String theatreName) {
		this.theatreName = theatreName;
	}
	public TheatreCity getTheatreCity() {
		return theatreCity;
	}
	public void setTheatreCity(TheatreCity theatreCity) {
		this.theatreCity = theatreCity;
	}
	public List<TheatreScreen> getTheatreScreens() {
		return theatreScreens;
	}
	public void setTheatreScreens(List<TheatreScreen> theatreScreens) {
		this.theatreScreens = theatreScreens;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public boolean isTheatreApproval() {
		return theatreApproval;
	}
	public void setTheatreApproval(boolean theatreApproval) {
		this.theatreApproval = theatreApproval;
	}
}
