package com.skilldistillery.mentorme.services;

import com.skilldistillery.mentorme.entities.User;

public interface UserService {
	
	public User create(User user);
	
	public User show(int userId);
	
	public User update(int userId, User user);
	
	public boolean destroy(int userId);

}
