package com.mtb.ticket.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.mtb.ticket.model.Ticket;
import com.mtb.user.model.User;

public interface TicketRepo extends JpaRepository<Ticket, String> {
	@Query("from Ticket where user_user_id=?1 and status!='pending' order by ticket_id desc")
	List<Ticket> findByUser(int userId);
}
