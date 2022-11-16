package com.mtb.theatre.repository;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mtb.theatre.model.TheatreSeat;

@Transactional
public interface TheatreSeatRepository extends JpaRepository<TheatreSeat, String> {

}
