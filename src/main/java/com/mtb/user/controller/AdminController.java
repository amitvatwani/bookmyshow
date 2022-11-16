package com.mtb.user.controller;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.service.TheatreCityService;
import com.mtb.theatre.service.TheatreService;
import com.mtb.user.model.User;
import com.mtb.user.service.AdminService;
import com.mtb.user.service.UserService;

@Controller
public class AdminController {
	
	Logger logger = LoggerFactory.getLogger(AdminController.class);
	@RequestMapping("logMappingAdmin")
	public String logMapping() {
		logger.trace("trace");
		logger.debug("debug");
		logger.warn("warn");
		logger.error("error");
		return "Welcome to logs";
	}
	
	
	@Autowired
    private UserService userService;
	@Autowired
	private TheatreService theatreService;
	@Autowired
	private TheatreCityService cityService;
	
	@RequestMapping("admin/adminHome")
    public String adminHome() {
        return "adminHome";
    }
	
	@RequestMapping("/admin/addCityPage")
	public ModelAndView addCityPage(ModelAndView md,TheatreCity city) {
		md.addObject("city", city).setViewName("addCity");
		return md;
		
	}
	
	@RequestMapping("/admin/viewTheatres")
	public ModelAndView getAllTheatres(ModelAndView md) {
		List<Theatre> theatres = theatreService.getAllTheatres();
		md.addObject("theatres",theatres);
		md.setViewName("viewTheatres");
		logger.info("Viewing theatres to admin");
		return md;
	}
	
	@RequestMapping("/admin/approveTheatre")
	public ModelAndView approveTheatre(@RequestParam("id") String theatreId, ModelAndView md) {
		Theatre theatre = theatreService.approveTheatre(theatreId);
		if(theatre!=null) {
			List<Theatre> theatres = theatreService.getAllTheatres();
			md.addObject("theatres",theatres);
			md.addObject("theatreApproveSuccess","Theatre Approved");
		}
		logger.info("Theatre Approved " +theatreId);
		md.setViewName("viewTheatres");
		return md;
	}
	
	@RequestMapping("/admin/disApproveTheatre")
	public ModelAndView disApproveTheatre(@RequestParam("id") String theatreId, ModelAndView md) {
		Theatre theatre = theatreService.disApproveTheatre(theatreId);
		if(theatre!=null) {
			List<Theatre> theatres = theatreService.getAllTheatres();
			md.addObject("theatres",theatres);
			md.addObject("theatreDisApproveSuccess","Theatre DisApproved");
		}
		logger.info("Theatre DisApproved " +theatreId);
		md.setViewName("viewTheatres");
		return md;
	}
	
	@RequestMapping("/admin/viewCityPage")
    public ModelAndView viewCity(ModelAndView md) {
        List<TheatreCity> cities=cityService.getAllCities();
        md.addObject("cities",cities).setViewName("viewCities");
        logger.info("Viewing cities to admin");
        return md;
    }
    
    @RequestMapping("/admin/updateCityPage")
    public ModelAndView updateMoviePage(@RequestParam("cityId") int cityId, ModelAndView md) {
        TheatreCity city=cityService.getCitiesById(cityId);
        md.addObject("city",city).setViewName("updateCity");
        logger.info("updating cities by admin");
        return md;
    }
    
    @RequestMapping("/admin/adminProfilePage")
    public ModelAndView viewProfile(ModelAndView md, HttpSession ses) {
        User user=(User) ses.getAttribute("user");
        md.addObject("user",user).setViewName("adminProfile");
        return md;
    }
    
    @RequestMapping("/admin/updateAdminProfile")
    public ModelAndView updateProfile(@Valid @ModelAttribute("user") User user, BindingResult br, ModelAndView md, HttpSession ses) {
        User user1=(User) ses.getAttribute("user");
        
        if (br.hasErrors()) {
            System.out.println(br);
            md.setViewName("adminProfile");
            logger.warn("Check Validations");
        }
        else if(!user1.getUserEmail().equals(user.getUserEmail())) {
                if(userService.checkIfUserExists(user.getUserEmail())) {
                    md.addObject("userExists", "email already exists");
                    logger.error("email already exists"+user1.getUserEmail());
                    md.setViewName("adminProfile");
                }
        }
        else {
            user.setUserId(user1.getUserId());
            user.setUserRole(user1.getUserRole());
            User updatedUser = userService.updateProfile(user);
            ses.setAttribute("user", updatedUser);
            logger.info( "Update SuccessFull"+user1.getUserId());
            md.addObject("user", updatedUser).addObject("success", "Update SuccessFull");
            md.setViewName("adminProfile");
        }
        return md;
        
    }
    @RequestMapping("/admin/deleteTheatreByAdmin")
    public ModelAndView deleteTheatre(HttpSession ses, ModelAndView md, @RequestParam("id") String theatreId) {
     boolean t=theatreService.deleteTheatre(theatreId);
        if(t) {
            md.addObject("theatreDeletedSuccess","Theatre Deleted");
        }
        else md.addObject("theatreDeletedSuccess","Theatre not Deleted ");
        List<Theatre> theatres = theatreService.getAllTheatres();
		md.addObject("theatres",theatres);
		md.setViewName("viewTheatres");
        return md;
    }   	
}
