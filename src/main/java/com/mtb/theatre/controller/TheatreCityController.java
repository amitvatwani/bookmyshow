package com.mtb.theatre.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.service.TheatreCityService;
import com.mtb.user.model.User;

@Controller
@RequestMapping("/admin")
public class TheatreCityController {
	
	@Autowired
	private TheatreCityService cityService;
	
	
//	@RequestMapping("addCity")
//	public ModelAndView addCity(TheatreCity trCity)
//	{
//		TheatreCity t=tcs.addCity(trCity);
//		return null;
//	}
//	
	
//	@RequestMapping("/addCity")
//	public ModelAndView addCity(ModelAndView md, TheatreCity trCity)
//	{
//		TheatreCity t=tcs.addCity(trCity);
//		if(t!=null)
//			md.addObject("success","city added");
//		else
//			md.addObject("failed","city not added");
//		return md;
//	}
	
	
	@RequestMapping("/addCity")
	public ModelAndView addCity(TheatreCity city,ModelAndView md) {
		cityService.addCity(city);
		md.addObject("success", "city added successfully").setViewName("addCity");
		return md;
	}
	
	@RequestMapping("/deleteCity")
	public ModelAndView deleteCity(@RequestParam("cityId") int cityId,ModelAndView md)
	{
		cityService.deleteCity(cityId);
		md.addObject("success","city was deleted").setViewName("adminHome");
		return md;
	}
	
	@RequestMapping("updateCity")
	public ModelAndView updateCity(ModelAndView md, TheatreCity trCity)
	{
		TheatreCity t=cityService.updateCity(trCity);
		if(t!=null)
			md.addObject("success","city updated").setViewName("adminHome");
		else
			md.addObject("failed","city not updated").setViewName("adminHome");
		return md;
	}
	
	@RequestMapping("getAllCities")
	public ModelAndView getAllCities(ModelAndView md)
	{
		List<TheatreCity> t=cityService.getAllCities();
		if(t!=null)
			md.addObject("success",t).setViewName("allCities");
		else
			md.addObject("failed","there are no cities to display").setViewName("allCities");
		return md;
	}
	
	@RequestMapping("getCitiesById")
	public ModelAndView getCitiesById(ModelAndView md,int cityId)
	{
		TheatreCity t=cityService.getCitiesById(cityId);
		if(t!=null)
			md.addObject("success",t).setViewName("allCities");
		else
			md.addObject("failed","there are no cities to display").setViewName("allCities");
		return md;
	}


}
