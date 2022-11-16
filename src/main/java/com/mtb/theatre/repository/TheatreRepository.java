package com.mtb.theatre.repository;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.mtb.theatre.model.Theatre;

@Transactional
public interface TheatreRepository extends JpaRepository<Theatre, String> {
	  @Query("from Theatre where user_user_id=?1")
	    List<Theatre> getTheatreByUserId(int userId);
	  @Modifying
	  @Query("update Theatre t set t.theatreApproval=true where t.theatreId=?1")
	  int updateTheatre(String theatreId);
	  @Modifying
	  @Query("update Theatre t set t.theatreApproval=false where t.theatreId=?1")
	  int disApproveTheatre(String theatreId);
	  List<Theatre> findByTheatreNameContainingAndTheatreApprovalTrue(String theatreName);
}
