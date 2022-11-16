package com.mtb.theatre.repository;



import org.springframework.data.jpa.repository.JpaRepository;

import com.mtb.theatre.model.TheatreScreen;

public interface TheatreScreenRepository extends JpaRepository<TheatreScreen, String> {
	
}
