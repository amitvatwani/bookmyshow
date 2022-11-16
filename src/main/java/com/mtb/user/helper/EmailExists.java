package com.mtb.user.helper;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import javax.validation.Constraint;
import javax.validation.Payload;

import org.springframework.context.annotation.Import;

import com.mtb.user.service.UserService;
@Import({UserService.class})
@Constraint(validatedBy = EmailExistsValidator.class)
@Target( { ElementType.METHOD, ElementType.FIELD } )
@Retention(RetentionPolicy.RUNTIME)
public @interface EmailExists {
public String message() default "email already exists";
//represents group of constraints
public Class<?>[] groups() default {};
//represents additional information about annotation
public Class<? extends Payload>[] payload() default {};
}