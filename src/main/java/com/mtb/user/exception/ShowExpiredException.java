package com.mtb.user.exception;

public class ShowExpiredException extends RuntimeException {
	
	private String errorCode;
	private String errorMessage;

	public String getErrorCode() {
	return errorCode;
	}

	public void setErrorCode(String errorCode) {
	this.errorCode = errorCode;
	}

	public String getErrorMessage() {
	return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
	this.errorMessage = errorMessage;
	}

	public ShowExpiredException(String errorCode, String errorMessage) {
		super();
		this.errorCode = errorCode;
		this.errorMessage = errorMessage;
	}

	public ShowExpiredException() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	
}
