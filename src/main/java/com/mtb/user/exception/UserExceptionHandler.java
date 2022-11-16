package com.mtb.user.exception;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;

import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.mtb.user.model.User;

@ControllerAdvice

public class UserExceptionHandler {
	@ExceptionHandler(UserNotFoundException.class)
    public String handleUserNotFoundException(UserNotFoundException userNotFound, Model md){
		if(userNotFound.getReason().equals("forgotPassword")) {
			md.addAttribute("failedEmail", userNotFound.getErrorMessage());
			return "forgotPassword";
		}
		md.addAttribute("message", userNotFound.getErrorMessage());
    	return "userLogin";
    }
	
	@ExceptionHandler(InvalidCredentialsException.class)
    public String handleInvalidCredentialsException(InvalidCredentialsException invalidCredetials, Model md){
		md.addAttribute("message",invalidCredetials.getErrorMessage());
		return "userLogin";
    }
	
	@ExceptionHandler(EmailExistsException.class)
    public String handleEmailExistsException(EmailExistsException emailExists, Model md, HttpServletRequest request){
		Map<String, String> map = new HashMap<>();
		map.put("userExists", emailExists.getErrorMessage());
		md.addAttribute("User", (User)request.getAttribute("User"));
		md.mergeAttributes(map);
		return "userSignup";
    }
	
	@ExceptionHandler(OtpVerificationFailedException.class)
    public String handleOtpVerificationFailedException(OtpVerificationFailedException otpVerificationFailed, Model md){
		md.addAttribute("failedOtp","Otp verification failed");
		Map<String, Object> map = new HashMap<>();
		map.put("checkOtp", true);
		md.mergeAttributes(map);
		return "forgotPassword";
    }
	
	@ExceptionHandler(OtpExpiredException.class)
    public String handleOtpExpiredException(OtpExpiredException otpExpired, Model md){
		md.addAttribute("failedOtp",otpExpired.getErrorMessage());
		Map<String, Object> map = new HashMap<>();
		map.put("checkOtp", true);
		md.mergeAttributes(map);
		return "forgotPassword";
    }
	
	@ExceptionHandler(ShowExpiredException.class)
    public String handleShowExpiredException(ShowExpiredException showExpired, Model md){
		md.addAttribute("message", showExpired.getErrorMessage());
		return "cancel";
    }
	
	
}
