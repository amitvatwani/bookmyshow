package com.mtb.movie.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mtb.movie.model.Movie;

public interface MovieRepository extends JpaRepository<Movie, String> {

	public List<Movie> findByGenre(String genre);
	public List<Movie> findByMovieTitleContaining(String movieTitle);
}
