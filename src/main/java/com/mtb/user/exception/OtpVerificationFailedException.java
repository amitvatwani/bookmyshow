package com.mtb.user.exception;

import org.springframework.stereotype.Component;

@Component
public class OtpVerificationFailedException extends RuntimeException{
	private String errorCode;
    private String errorMessage;
    
    public OtpVerificationFailedException(String errorCode, String errorMessage) {
        super();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }
    
    public OtpVerificationFailedException() {
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
}
