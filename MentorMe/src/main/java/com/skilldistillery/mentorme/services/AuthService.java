package com.skilldistillery.mentorme.services;

import com.skilldistillery.mentorme.entities.User;

public interface AuthService {
	 public User register(User user);
	    public User getUserByUsername(String username);
		User getUserById(int userId);
}
