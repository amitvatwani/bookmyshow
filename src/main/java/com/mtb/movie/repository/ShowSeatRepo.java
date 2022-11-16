package com.mtb.movie.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.mtb.movie.model.ShowSeat;
import com.mtb.movie.model.Shows;

@Transactional
public interface ShowSeatRepo extends JpaRepository<ShowSeat, String> {
	@Modifying
	@Query("update ShowSeat showseat set showseat.status=?1 where showseat.ticket.ticketId=?2")
	int updateSeatStatus(String status, String ticketId);

	List<ShowSeat> findByShow(Shows show);
	
}
