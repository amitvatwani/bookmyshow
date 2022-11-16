package com.mtb.theatre.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mtb.theatre.model.TheatreCity;

public interface TheatreCityRepository extends JpaRepository<TheatreCity, Integer> {
	public TheatreCity findByCityName(String name);
}
