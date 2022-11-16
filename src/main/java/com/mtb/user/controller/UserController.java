package com.mtb.user.controller;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.movie.model.Movie;
import com.mtb.movie.model.Shows;
import com.mtb.movie.service.MovieService;
import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.model.TheatreScreen;
import com.mtb.theatre.service.TheatreCityService;
import com.mtb.theatre.service.TheatreService;
import com.mtb.user.exception.EmailExistsException;
import com.mtb.user.exception.InvalidCredentialsException;
import com.mtb.user.exception.OtpExpiredException;
import com.mtb.user.exception.OtpVerificationFailedException;
import com.mtb.user.exception.UserNotFoundException;
import com.mtb.user.helper.AttrWrapper;
import com.mtb.user.helper.changePassword;
import com.mtb.user.helper.signup;
import com.mtb.user.model.User;
import com.mtb.user.model.UserOtp;
import com.mtb.user.model.UserPrincipal;
import com.mtb.user.service.UserService;

@Controller
public class UserController {
	
	Logger logger = LoggerFactory.getLogger(UserController.class);
	
	
	@Autowired
	private UserService userService;
	@Autowired
	private  TheatreCityService theatreCityService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private TheatreService theatreService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@RequestMapping(value={"", "/index"})
	public ModelAndView getIndex(ModelAndView md, HttpSession ses) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!auth.getPrincipal().equals("anonymousUser")) {
			UserPrincipal principal = (UserPrincipal) auth.getPrincipal();
			User validUser = principal.getUser();
			if(validUser !=null) {
				ses.setAttribute("user", validUser);
			}
		}
		List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
        List<Theatre> theatres=theatreCities.get(0).getTheatres();
		Set<Movie> movies=new HashSet<Movie>();
		for(Theatre t:theatres) {
			for(TheatreScreen ts:t.getTheatreScreens()) {
				for(Shows sh:ts.getShows()) {
					movies.add(sh.getMovie());
				}
			}
		}
		logger.info("Welcome to index page");
		md.addObject("firstLocation", true);
        md.addObject("movies",movies);
        md.setViewName("index");
		return md;
	}
	
	@RequestMapping("userLogin")
    public String userLogin() {
		logger.info("on to the user login page");
        return "userLogin";
    }
	
	@RequestMapping("userSignup")
    public String userSignup(User user, Model m) {
        m.addAttribute("User",user);
        logger.info("on to the userSignup page");
        return "userSignup";
    }
	
	@RequestMapping("forgotPassword")
    public String forgotPassword() {
		logger.info("on to the forgotPassword page");
        return "forgotPassword";
    }
	
	
	
	@RequestMapping("/addUser")
	public ModelAndView addUser(ModelAndView md, @Validated(signup.class) @ModelAttribute("User") User user, BindingResult br, HttpServletRequest request) {
		if (br.hasErrors()) {
			System.out.println(br);
			logger.warn("Follow the Validations");
            md.setViewName("userSignup");
        }
		else if(userService.checkIfUserExists(user.getUserEmail())) {
			request.setAttribute("User", user);
			logger.warn("Email Already exists");
			throw new EmailExistsException("401", "Email already exists");
		}
		else {
			user.setUserPassword(passwordEncoder.encode(user.getUserPassword()));
			User createdUser = userService.addUser(user);
			md.addObject("user", createdUser).addObject("signupSuccess", "Signup SuccessFull Please Login");
			md.setViewName("userLogin");
			logger.info("Successfully signed up"+user.getUserId());
		}
		return md;
	}
	
	@RequestMapping("/loginValidation")
    public ModelAndView loginValidation(User user,ModelAndView md, HttpSession ses) {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		UserPrincipal principal = (UserPrincipal) auth.getPrincipal();
		User validUser = principal.getUser();
	            if(validUser!=null) {
	            	logger.info("User Found"+validUser.getUserId());
	                ses.setAttribute("user", validUser);
	                if(validUser.getUserRole().equals("ROLE_USER") || validUser.getUserRole().equals("ROLE_THEATREOWNER")||
	                		validUser.getUserRole().equals("ROLE_ADMIN")) {
	                	
	                	List<TheatreCity> theatreCities=theatreCityService.getAllCities();
	                    md.addObject("theatreCity", theatreCities);
	                    List<Theatre> theatres=theatreCities.get(0).getTheatres();
	            		Set<Movie> movies=new HashSet<Movie>();
	            		for(Theatre t:theatres) {
	            			for(TheatreScreen ts:t.getTheatreScreens()) {
	            				for(Shows sh:ts.getShows()) {
	            					movies.add(sh.getMovie());
	            				}
	            			}
	            		}
	            		logger.info(validUser.getUserRole()+"Redirecting to index");
	            		md.addObject("firstLocation", true);
	                    md.addObject("movies",movies);
	                    md.addObject("user",validUser).setViewName("index");
	                }
	                return md;
	            }
	            else {
	            	logger.error("Wrong Credintials");
	                throw new InvalidCredentialsException("401", "Invalid Credentials");
	            }
	        
    	
    }
	
	@RequestMapping("/sendOtp")
    public ModelAndView sendOtp(ModelAndView md, @RequestParam("userEmail") String userEmail, HttpSession ses) {
		boolean userExist = userService.checkIfUserExists(userEmail);
		if(userExist) {
			User user = userService.getUser(userEmail);
			logger.info("user Exists "+user.getUserId());
			UserOtp userOtp = user.getOtp();
			long currentTime = new Date().getTime();
			int difference=0;
			if(userOtp.getAccessTime()!=null)
				logger.info("Multiple Otp generation");
				difference = (int)(currentTime - userOtp.getAccessTime().getTime())/60000;
			if(userOtp.getOtpCount()==0) {
				logger.info("Otp Generated first time");
				user.getOtp().setOtpCount(1);
				user.getOtp().setAccessTime(new Date());
		    	try {
					String otp = userService.sendmail(userEmail);
					logger.info("Otp sent to "+userEmail);
					ses.setAttribute("otp", new AttrWrapper<>(otp, 180*1000));
					ses.setAttribute("userEmail", userEmail);
					md.addObject("otpSuccess", "Otp has been sent to your email.").addObject("userEmail",userEmail).addObject("checkOtp", true);
					md.setViewName("forgotPassword");
					userService.updateOtpCount(userOtp);
				}catch (Exception e) {
					logger.error("Error sending Otp");
					md.addObject("error", "Try again later");
					md.setViewName("forgotPassword");
					e.printStackTrace();
				}
			}
			else if(difference>2){
				userOtp.setOtpCount(1);
				userOtp.setAccessTime(new Date());
				
				try {
					String otp = userService.sendmail(userEmail);
					logger.info("Otp sent to "+userEmail);
					ses.setAttribute("otp", new AttrWrapper<>(otp, 180*1000));
					ses.setAttribute("userEmail", userEmail);
					md.addObject("otpSuccess", "Otp has been sent to your email.").addObject("userEmail",userEmail).addObject("checkOtp", true);
					md.setViewName("forgotPassword");
					userService.updateOtpCount(userOtp);
				}catch (Exception e) {
					logger.error("Error sending Otp");
					md.addObject("error", "Try again later");
					md.setViewName("forgotPassword");
					e.printStackTrace();
				}
			}
			else if(userOtp.getOtpCount()<3 && difference<=2) {
				userOtp.setOtpCount(userOtp.getOtpCount()+1);
				try {
					String otp = userService.sendmail(userEmail);
					logger.info("Otp sent to "+userEmail);
					ses.setAttribute("otp", new AttrWrapper<>(otp, 180*1000));
					ses.setAttribute("userEmail", userEmail);
					md.addObject("otpSuccess", "Otp has been sent to your email.").addObject("userEmail",userEmail).addObject("checkOtp", true);
					md.setViewName("forgotPassword");
					userService.updateOtpCount(userOtp);
				}catch (Exception e) {
					logger.error("Error sending Otp");
					md.addObject("error", "Try again later");
					md.setViewName("forgotPassword");
					e.printStackTrace();
				}
			}
			else {
				logger.warn("limit Exceded, try after 60  minutes "+userEmail);
				md.addObject("failedOtp", "limit Exceded, try after 60  minutes").addObject("userEmail",userEmail);
				md.setViewName("forgotPassword");
			}
		}
		else {
			logger.error("User does not exists ");
			throw new UserNotFoundException("401", "User does not exists", "forgotPassword");
		}
    	return md;
    }
	
	@RequestMapping("/verifyOtp")
	public ModelAndView verifyOtp(@RequestParam("otp") String enteredOtp,
			HttpSession ses, ModelAndView md, User user, Model m) {
		
		@SuppressWarnings("unchecked")
		AttrWrapper<String> attr = (AttrWrapper<String>) ses.getAttribute("otp");
		if(attr!=null) {
			if(attr.isValid()) {
				String otpFromSession = (String) attr.value;
				if(otpFromSession.equals(enteredOtp)) {
					logger.info("Otp Verification Successfull "+user.getUserId());
					m.addAttribute("User", user);
					md.addObject("successOtp", "Otp Verification Successfull");
					md.setViewName("changePassword");
				}
				else {
					logger.error("Otp verification failed");
					throw new OtpVerificationFailedException("401", "Otp verification failed");
				}
			}
			else {
				logger.error("Otp verification failed/Expired");
				throw new OtpExpiredException("401", "Otp verification failed/Expired");
			}
		}
		else {
			logger.error("Otp verification failed/Expired");
			throw new OtpExpiredException("401", "Otp verification failed/Expired");
		}
		return md;
	}
	
	@RequestMapping("/passwordChangeSuccess")
	public ModelAndView passwordChangeSuccess(ModelAndView md,  @Validated(changePassword.class) @ModelAttribute("User") User user,
			BindingResult br, HttpSession ses) {
		if (br.hasErrors()) {
            md.setViewName("changePassword");
            logger.warn("Follow Validations" +user.getUserId());
        }
		else {
			String userEmail = (String)ses.getAttribute("userEmail");
			user.setUserEmail(userEmail);
			boolean updateSuccess = userService.updatePassword(user);
			if(updateSuccess) {
				logger.info("Password Successfully Changed.");
				md.addObject("passwordChangeSuccess", "Password Successfully Changed.").setViewName("userLogin");
			}
				else {
					logger.error("Unable to update password");
					md.addObject("passwordChangeFailed", "Unable to update password").setViewName("changePassword");
			}
		}
		return md;
	}
	
	@RequestMapping("viewProfile")
	public ModelAndView viewProfile(ModelAndView md, HttpSession ses) {	
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		if(!auth.getPrincipal().equals("anonymousUser")) {
			UserPrincipal principal = (UserPrincipal) auth.getPrincipal();
			User validUser = principal.getUser();
			if(validUser !=null) {
				ses.setAttribute("user", validUser);
			}
			md.addObject("user",validUser).setViewName("viewProfile");
			logger.info("Viewing profile");
			return md;
		}
		else {
			md.setViewName("userLogin");
			return md;
		}
	}
	
	@RequestMapping("logoutUser")
	public ModelAndView logoutUser(ModelAndView md, HttpSession ses) {
		ses.invalidate();
		logger.info("user logged out");
		md.addObject("userLogoutSuccess", "Successfully Logged out").setViewName("userLogin");
		return md;
	}
	
	@RequestMapping("updateProfile")
	public ModelAndView updateProfile(@Valid @ModelAttribute("user") User user, BindingResult br, ModelAndView md, HttpSession ses) {
		User user1=(User) ses.getAttribute("user");
		if (br.hasErrors()) {
			System.out.println(br);
            md.setViewName("viewProfile");
            md.addObject("edit","edit");
            logger.warn("Follow Validations");
        }
		else if(!user1.getUserEmail().equals(user.getUserEmail())) { 
				if(userService.checkIfUserExists(user.getUserEmail())) {
					md.addObject("userExists", "email already exists");
					logger.warn("email already exists "+user.getUserId());
					md.setViewName("viewProfile");
					md.addObject("edit","edit");
				}
		}
		else {
			user.setUserId(user1.getUserId());
			user.setUserRole(user1.getUserRole());
			User updatedUser = userService.updateProfile(user);
			ses.setAttribute("user", updatedUser);
			logger.info("Updated SuccessFull "+user.getUserId());
			md.addObject("user", updatedUser).addObject("success", "Updated SuccessFull");
			md.setViewName("viewProfile");
		}
		return md;
		
	}
	
	@RequestMapping("searchMoviesAndTheatre/{search}")
	@ResponseBody
	public LinkedHashMap<String, List<LinkedHashMap<String, String>>> searchMovies(@PathVariable("search") String movieTitle
			, HttpSession ses) {
		
		List<LinkedHashMap<String, String>> movieList = new ArrayList<LinkedHashMap<String, String>>();
		List<Movie> movies= movieService.searchMovies(movieTitle);
		movies.forEach((e)->{
			LinkedHashMap<String, String> movie = new LinkedHashMap<String, String>();
			movie.put("movieTitle", e.getMovieTitle());
			movie.put("movieId", e.getMovieId());
			movie.put("movieLanguage", e.getMovieLanguage());
			movie.put("moviePoster", e.getMoviePoster());
			movieList.add(movie);
		});
		LinkedHashMap<String, List<LinkedHashMap<String, String>>> searchData = new LinkedHashMap<String, List<LinkedHashMap<String, String>>>();
		searchData.put("movies", movieList);
		List<LinkedHashMap<String, String>> theatreList = new ArrayList<LinkedHashMap<String, String>>();
		List<Theatre> theatres=theatreService.searchTheatre(movieTitle);
		theatres.forEach((e)->{
		LinkedHashMap<String, String> theatre = new LinkedHashMap<String, String>();
		theatre.put("theatreName", e.getTheatreName());
		theatre.put("theatreId", e.getTheatreId());
		theatreList.add(theatre);
	});
		searchData.put("theatres", theatreList);
		//User user=(User) ses.getAttribute("user");
		logger.info("viewing Searched Movie or theatre to ");
		return searchData;
	}
	
	@RequestMapping("moviesByCity")
	public ModelAndView moviesByCity(@RequestParam("theatreCityId") int cityId, ModelAndView md, HttpSession ses) {
		TheatreCity city= theatreCityService.getCitiesById(cityId);
		List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        md.addObject("theatreCity", theatreCities);
		List<Theatre> theatres=city.getTheatres();
		Set<Movie> movies=new HashSet<Movie>();
		for(Theatre t:theatres) {
			for(TheatreScreen ts:t.getTheatreScreens()) {
				for(Shows sh:ts.getShows()) {
					movies.add(sh.getMovie());
				}
			}
		}
		md.addObject("city",city);
		md.addObject("movies",movies);
		md.setViewName("index");
		User user=(User) ses.getAttribute("user");
		logger.info("Viewing Movies By City to "+user.getUserId());
		return md;
	}
	@RequestMapping("selectMovieTheatres")
    public ModelAndView selectMovieTheatres(@RequestParam("date") String today, ModelAndView md,
    		@RequestParam("cityId") int cityId,@RequestParam("movieId") String movieId , HttpSession ses) {
		System.out.println(today);
		 SimpleDateFormat formatter=new SimpleDateFormat("dd-MMM-yyyy");
		 String dateArray[] = today.split(" ");
		 String todaysDate = dateArray[2]+"-"+dateArray[1]+"-"+dateArray[5];
		 Date date=null;
		 try {
			date=formatter.parse(todaysDate);
		} catch (ParseException e1) {
			e1.printStackTrace();
		} 
		 
        Set<Theatre> theatres=new HashSet<Theatre>();
        Movie movie=movieService.selectMovie(movieId);
        List<Shows> shows=movie.getShows();
        TheatreCity city=theatreCityService.getCitiesById(cityId);
        List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        theatreCities.remove(city);
        md.addObject("theatreCity", theatreCities);
        for(Shows sh:shows) {
            Theatre theatre=sh.getTheatreScreen().getTheatre();
            if(theatre.getTheatreCity().getCityId()== cityId) {
                theatres.add(theatre);
                
            }
        }
        md.addObject("date", date);
        md.addObject("movie", movie);
        md.addObject("theatres",theatres).addObject("movieId",movieId).addObject("city",city).setViewName("selectMovieTheatres");    
        
        logger.info("Selecting Theatres for a specific movie");
        return md;
    }
    
    @RequestMapping("selectTheatreMovies")
    public ModelAndView selectTheatreMovies(ModelAndView md, @RequestParam("cityId") int cityId,
    		@RequestParam("theatreId") String theatreId ,HttpSession ses) {
        Set<Movie> movies=new HashSet<Movie>();
        Theatre theatre=theatreService.getTheatreById(theatreId);
        List<TheatreScreen>theatreScreens=theatre.getTheatreScreens();
        TheatreCity city=theatreCityService.getCitiesById(cityId);
        List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        theatreCities.remove(city);
        for(TheatreScreen ts:theatreScreens) {
            for(Shows sh:ts.getShows()) {
                    movies.add(sh.getMovie());
                }
            }
        md.addObject("theatre",theatre);
        md.addObject("movies",movies).addObject("theatreId",theatreId).addObject("city",city).setViewName("selectTheatreMovies");
        User user=(User) ses.getAttribute("user");
        logger.info("Selecting Movies for a specific theatre "+user.getUserId());
        return md;
    }
    
    @RequestMapping("selectMovieTheatresByDate")
    public ModelAndView selectMovieTheatresByDate(@RequestParam("date") String today, ModelAndView md, 
    		@RequestParam("cityId") int cityId,@RequestParam("movieId") String movieId ,HttpSession ses) {
		System.out.println(today);
		
		Date d = new Date();
        Set<Theatre> theatres=new HashSet<Theatre>();
        Movie movie=movieService.selectMovie(movieId);
        List<Shows> shows=movie.getShows();
        TheatreCity city=theatreCityService.getCitiesById(cityId);
        List<TheatreCity> theatreCities=theatreCityService.getAllCities();
        theatreCities.remove(city);
        md.addObject("theatreCity", theatreCities);
        for(Shows sh:shows) {
            Theatre theatre=sh.getTheatreScreen().getTheatre();
            if(theatre.getTheatreCity().getCityId()== cityId) {
                theatres.add(theatre);
                
            }
        }
        md.addObject("date", d);
        md.addObject("movie", movie);
        md.addObject("theatres",theatres).addObject("movieId",movieId).addObject("city",city).setViewName("selectMovieTheatres");    
        User user=(User) ses.getAttribute("user");
        logger.info("Selecting Movies and theatre for a specific Date "+user.getUserId());
        return md;
    }
}
