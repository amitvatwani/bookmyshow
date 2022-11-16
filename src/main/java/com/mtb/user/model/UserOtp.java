package com.mtb.user.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
@Entity
public class UserOtp {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;
	private int otpCount;
	private Date accessTime;
	public int getOtpCount() {
		return otpCount;
	}
	public void setOtpCount(int otpCount) {
		this.otpCount = otpCount;
	}
	public Date getAccessTime() {
		return accessTime;
	}
	public void setAccessTime(Date accessTime) {
		this.accessTime = accessTime;
	}
}
