package com.skilldistillery.mentorme.services;

import java.util.List;

import com.skilldistillery.mentorme.entities.User;

public interface UserService {
	
	
	public User show(int userId);
	
	public User update(String username, User user);
	
	public boolean destroy(String username);

	List<User> getUsersFollowers(String username);

	List<User> getUsersFollowing(String username);

}
