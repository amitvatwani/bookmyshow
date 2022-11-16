package com.mtb.ticket.exception;

public class SeatAlreadyBookedException extends RuntimeException {
	private String errorCode;
    private String errorMessage;
    
    public SeatAlreadyBookedException(String errorCode, String errorMessage) {
        super();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }
    
    public SeatAlreadyBookedException() {
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
