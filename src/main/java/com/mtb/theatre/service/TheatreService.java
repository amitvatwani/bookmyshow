package com.mtb.theatre.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.theatre.model.Theatre;
import com.mtb.theatre.model.TheatreCity;
import com.mtb.theatre.repository.TheatreCityRepository;
import com.mtb.theatre.repository.TheatreRepository;
import com.mtb.user.model.User;
import com.mtb.user.repository.UserRepository;

@Service
public class TheatreService {

	@Autowired
	private TheatreRepository theatreRepo;
	@Autowired
	private TheatreCityRepository cityRepo;
	@Autowired
	private UserRepository userRepo;
	
	public Theatre addTheatre(String theatreName, String city, User user) {
		Theatre theatre = new Theatre();
		theatre.setTheatreName(theatreName);
		TheatreCity theatreCity = cityRepo.findByCityName(city);
		theatre.setUser(user);
        theatre.setTheatreApproval(false);
        theatre.setTheatreCity(theatreCity);
        theatreCity.getTheatres().add(theatre);
		Theatre t= theatreRepo.save(theatre);
		
		if(t!=null) {
			return t;
		}
		else return null;
	}
	public List<Theatre> getAllTheatresByUser(int userId) {
        return theatreRepo.getTheatreByUserId(userId);
    }
	public boolean deleteTheatre(String id){
		Theatre t=theatreRepo.findById(id).get();
		theatreRepo.deleteById(id);
		if(t!=null) {
			return true;
		}
		else return false;
	}
	
	public boolean updateTheatre(String theatreId,String theatreName, String theatreCity){
		Theatre theatre = theatreRepo.findById(theatreId).get();
		theatre.setTheatreName(theatreName);
		TheatreCity city = cityRepo.findByCityName(theatreCity);
		theatre.setTheatreCity(city);
		theatreRepo.save(theatre);
		if(theatre!=null) {
			return true;
		}
		else return false;
	}
	
	public List<Theatre> getAllTheatres(){
		return theatreRepo.findAll();
	}
	
	public Theatre getTheatreById(String id) {
		return theatreRepo.findById(id).get();
	}
	
	public Theatre approveTheatre(String theatreId) {
		int res = theatreRepo.updateTheatre(theatreId);
		Theatre theatre=null;
		if(res>0) {
			theatre = theatreRepo.findById(theatreId).get();
			int result = userRepo.updateRole(theatre.getUser().getUserId());
		}
		return theatre;
	}
	
	public Theatre disApproveTheatre(String theatreId) {
		int res = theatreRepo.disApproveTheatre(theatreId);
		Theatre theatre=null;
		if(res>0) {
			theatre = theatreRepo.findById(theatreId).get();
			if(theatre.getUser().getTheatres().size()==0) {
				int result = userRepo.updateRoleToUser(theatre.getUser().getUserId());
			}
		}
		return theatre;
	}
	public List<Theatre> searchTheatre(String theatreName){
        List<Theatre> theatres = theatreRepo.findByTheatreNameContainingAndTheatreApprovalTrue(theatreName);
        
        return theatres;
    }	

}
