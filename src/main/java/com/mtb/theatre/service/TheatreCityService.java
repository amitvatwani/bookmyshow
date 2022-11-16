package com.mtb.theatre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.repository.TheatreCityRepository;

@Service
public class TheatreCityService {
	
	@Autowired
	private TheatreCityRepository cityRepo;

	public TheatreCity addCity(TheatreCity theatrecity) {
		TheatreCity t=cityRepo.save(theatrecity);
		if(t!=null)
			return t;
		return null;
	}

	public boolean deleteCity(int cityId) {
        if(cityRepo.findById(cityId)!=null) {
        cityRepo.deleteById(cityId);
        return true;
        }return false;
    }

	public TheatreCity updateCity(TheatreCity trCity) {
		cityRepo.save(trCity);
		TheatreCity t=cityRepo.findById(trCity.getCityId()).get();
		if(t!=null)
			return cityRepo.save(t);
		return null;
	}

	public List<TheatreCity> getAllCities() {
		return cityRepo.findAll();
	}

	public TheatreCity getCitiesById(int cityId) {
		TheatreCity t=cityRepo.findById(cityId).get();
		if(t!=null)
			return t;
		return null;
	}
	

}
