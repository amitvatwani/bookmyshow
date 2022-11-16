package com.mtb.user.model;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.ticket.model.Ticket;
//import com.mtb.user.helper.EmailExists;
import com.mtb.user.helper.Password;
import com.mtb.user.helper.changePassword;
import com.mtb.user.helper.signup;


@Entity
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int userId;
	@Size(min=3, message="Username must be minimum 3 characters", groups=signup.class)
	private String userName;
	@Password(groups= {changePassword.class, signup.class})
	private String userPassword;
	@Size(min=10, max=10, message="Mobile number must be 10 digits", groups=signup.class)
	private String userMobile;
	@NotBlank(message="Email cannot be empty", groups=signup.class)
	@Email(groups=signup.class)
	private String userEmail;
	@Column(columnDefinition = "varchar(20) default 'user'")
	private String userRole="ROLE_USER";
	@OneToOne
	private UserOtp otp;
	//@JsonManagedReference
	@OneToMany(mappedBy="user")
	private List<Ticket> tickets;
	//@JsonManagedReference
	@OneToMany(mappedBy="user")
	private List<Theatre> theatres;
	
	
	public UserOtp getOtp() {
		return otp;
	}
	public void setOtp(UserOtp otp) {
		this.otp = otp;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public String getUserMobile() {
		return userMobile;
	}
	public void setUserMobile(String userMobile) {
		this.userMobile = userMobile;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getUserRole() {
		return userRole;
	}
	public void setUserRole(String userRole) {
		this.userRole = userRole;
	}
	public List<Ticket> getTickets() {
		return tickets;
	}
	public void setTickets(List<Ticket> tickets) {
		this.tickets = tickets;
	}
	public List<Theatre> getTheatres() {
		return theatres;
	}
	public void setTheatres(List<Theatre> theatres) {
		this.theatres = theatres;
	}
	
	
}

