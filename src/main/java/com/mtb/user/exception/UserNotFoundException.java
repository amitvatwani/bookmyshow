package com.mtb.user.exception;

import org.springframework.stereotype.Component;

@Component
public class UserNotFoundException  extends RuntimeException {
	private String errorCode;
    private String errorMessage;
    private String reason;
    

	public UserNotFoundException(String errorCode, String errorMessage, String reason) {
        super();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
        this.reason = reason;
    }
    
    public UserNotFoundException() {
        super();
    }
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
    public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}
}	
