package com.mtb.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mtb.user.repository.UserRepository;

@Service
public class AdminService {

	@Autowired
	private UserRepository userRepo;
	
	
}
