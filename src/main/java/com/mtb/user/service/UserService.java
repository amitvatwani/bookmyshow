package com.mtb.user.service;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.mtb.user.model.User;
import com.mtb.user.model.UserOtp;
import com.mtb.user.repository.UserOtpRepository;
import com.mtb.user.repository.UserRepository;

@Service
public class UserService {
	
	@Autowired
    private UserRepository userRepo;
	
	@Autowired
	private UserOtpRepository otpRepo;
	
	@Autowired 
	private JavaMailSender javaMailSender;

   public User addUser(User user) {
	   	UserOtp userOtp=new UserOtp();
	   	otpRepo.save(userOtp);
	   	user.setOtp(userOtp);
        return userRepo.save(user);
    }
    
    public boolean delete(int id) {
        if(userRepo.findById(id)!=null) {
        	userRepo.deleteById(id);
            return true;
        }
        else return false;
    }
    
    public User loginValidation(User user) {
		// TODO Auto-generated method stub
		User validUser = userRepo.findByUserEmail(user.getUserEmail());
        if(validUser!=null)
            if(validUser.getUserPassword().equals(user.getUserPassword()))
            	return validUser;
        
        return null;
	}



   public boolean updateProfile(int userId) {
        User u = userRepo.findById(userId).orElse(null);
        if(u!=null) {
            u.setUserEmail(u.getUserEmail());
            u.setUserMobile(u.getUserMobile());
            u= userRepo.save(u);
        }
        return true;
    }
    
    public List<User> getallUsers(){
        return userRepo.findAll();
    }
    
    public boolean checkIfUserExists(String email) {
    	User user = userRepo.findByUserEmail(email);
    	if(user!=null) {
    		return true;
    	}
    	return false;
    }
    
    public User getUser(String email) {
    	return userRepo.findByUserEmail(email);
    	
    }
    
    public String sendmail(String recepient) {
    	String otp = new DecimalFormat("000000").format(new Random().nextInt(999999));
    	try {
            // Creating a simple mail message
            SimpleMailMessage mailMessage
                = new SimpleMailMessage();
            
            // Setting up necessary details
            mailMessage.setFrom("themovieticketbooking@gmail.com");
            mailMessage.setTo(recepient);
            mailMessage.setText(otp);
            mailMessage.setSubject("You otp to change password. Valid for 3 minutes.");
 
            // Sending the mail
            javaMailSender.send(mailMessage);
            
        }
 
        // Catch block to handle the exceptions
        catch (Exception e) {
             System.out.println("Error while Sending Mail");
        }
    	return otp;
    	
    }

	public boolean updatePassword(User user) {
		int res = userRepo.updatePassword(user.getUserEmail(), user.getUserPassword());
		return res>0;
	}

	public void updateOtpCount(UserOtp userOtp) {
		// TODO Auto-generated method stub
		otpRepo.save(userOtp);
	}
	
	public User updateProfile(User user) {
		return userRepo.save(user);
	}
    
}