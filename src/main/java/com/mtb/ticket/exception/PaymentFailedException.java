package com.mtb.ticket.exception;

public class PaymentFailedException extends RuntimeException{
	private String errorCode;
    private String errorMessage;
    
    public PaymentFailedException(String errorCode, String errorMessage) {
        super();
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }
    
    public PaymentFailedException() {
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
