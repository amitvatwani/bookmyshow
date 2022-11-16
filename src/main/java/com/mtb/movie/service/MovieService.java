package com.mtb.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.movie.model.Movie;
import com.mtb.movie.repository.MovieRepository;

@Service
public class MovieService {
	
	@Autowired
	private MovieRepository movieRepo;
	
	public Movie addMovie(Movie movie) {
		return movieRepo.save(movie);
	}
	
	public boolean deleteMovie(String movieId) {
		if(movieRepo.findById(movieId)!=null) {
			movieRepo.deleteById(movieId);
			return true;
		}return false;
		
	}
	
	public Movie updateMovie(Movie movie) {
		return movieRepo.save(movie);
	}
	
	public Movie selectMovie(String movieId) {
		return movieRepo.findById(movieId).get();
	}
	
	public List<Movie> showAllMovies(){
		return movieRepo.findAll();
	}
	
	public List<Movie> showMovieByGenre(String genre){
		return movieRepo.findByGenre(genre);
	}

	public List<Movie> getMovie() {
		// TODO Auto-generated method stub
		return movieRepo.findAll();
	}
	public List<Movie> searchMovies(String movieTitle){        
        return movieRepo.findByMovieTitleContaining(movieTitle);
        
    }
}
