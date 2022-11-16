package com.mtb.user.helper;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Import;

import com.mtb.user.service.UserService;
@Import({UserService.class})
public class EmailExistsValidator  implements ConstraintValidator<EmailExists, String> {
	
	@Autowired
	private UserService userService;
	
	@Override
    public void initialize(EmailExists arg0) {
    }
	
	public boolean isValid(String email, ConstraintValidatorContext cvc) {
		System.out.println(userService);
		return !(userService.checkIfUserExists(email));
	}
}
