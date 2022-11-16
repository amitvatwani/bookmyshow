package com.mtb.movie.repository;

import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;

import com.mtb.movie.model.Movie;

import com.mtb.movie.model.Shows;

public interface ShowRepository extends JpaRepository<Shows, String>{
	
	public List<Shows> findByMovie(Movie movie);

}
