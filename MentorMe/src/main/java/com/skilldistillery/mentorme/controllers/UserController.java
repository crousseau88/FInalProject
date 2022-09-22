package com.skilldistillery.mentorme.controllers;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.UserRepository;
import com.skilldistillery.mentorme.services.UserService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost/" })
public class UserController {
	
	@Autowired
	private UserRepository userRepo;

	@Autowired
	private UserService userServ;
	
	@PostMapping("register")
	public User createUser(HttpServletResponse res, @RequestBody User user) {
		try {
			User newUser = userServ.create(user);
			res.setStatus(200);
			return newUser;
		} catch (Exception e) {
			res.setStatus(400);
			return null;
		}
	}
	
	
	@GetMapping("account/{username}")
	public User getByUsername(@PathVariable String username, HttpServletResponse res) {
		User user = null;
		user = userRepo.findByUsername(username);
		if(user == null) {
			res.setStatus(404);
		}
		
		return user;
	}
	
	@PutMapping("auth/{userId}")
	public User updateUser(@PathVariable int userId, @RequestBody User user, HttpServletResponse res) {
		User updatedUser = null;
		
		try {
			updatedUser = userServ.update(userId, user);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		
		return updatedUser;
	}
	
	@DeleteMapping("auth/{userId}")
	public void deactivateUser(@PathVariable int userId, HttpServletResponse res) {
		if(userServ.destroy(userId)) {
			res.setStatus(200);
		}else {
			res.setStatus(400);
		}
	}

}
