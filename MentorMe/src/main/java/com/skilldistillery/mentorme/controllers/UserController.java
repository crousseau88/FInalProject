package com.skilldistillery.mentorme.controllers;

import java.security.Principal;
import java.util.List;

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

import com.skilldistillery.mentorme.entities.Reply;
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
	
	@GetMapping("{username}/followers")
	public List<User> getUsersFollowers(@PathVariable String username, HttpServletResponse res){
		List<User> followers = null;
		try {
			followers = userServ.getUsersFollowers(username);
			res.setStatus(200);
			return followers;
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return followers;
	}
	@GetMapping("{username}/following")
	public List<User> getUsersFollowing(@PathVariable String username, HttpServletResponse res){
		List<User> followers = null;
		try {
			followers = userServ.getUsersFollowing(username);
			res.setStatus(200);
			return followers;
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return followers;
	}
	
	@GetMapping("{userId}")
	public User getById(@PathVariable int userId, HttpServletResponse res) {
		try {
			User user = userServ.show(userId);
			res.setStatus(200);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
			res.setStatus(400);
			return null;
		}
	}
	
	@GetMapping("account/{username}")
	public User getByUsername(@PathVariable String username, HttpServletResponse res) {
		User user = null;
		user = userRepo.findByUsername(username);
		if(user != null && user.getActive()) {
			res.setStatus(200);
			return user;
		}else {
			res.setStatus(404);
			return null;
		}
	}
	
	@PutMapping("account")
	public User updateUser( @RequestBody User user, HttpServletResponse res, Principal principal) {
		User updatedUser = null;
		
		try {
			updatedUser = userServ.update(principal.getName(), user);
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		
		return updatedUser;
	}
	
	@DeleteMapping("account")
	public void deactivateUser(Principal principal, HttpServletResponse res) {
		if(userServ.destroy(principal.getName())) {
			res.setStatus(200);
		}else {
			res.setStatus(400);
		}
	}
	
	@PutMapping("follower/{followThisUserId}")
	public List<User> followAUser(@PathVariable int followThisUserId, @RequestBody User user, HttpServletResponse res, Principal principal) {
		List<User> followers = null;
		try {
			followers = userServ.addAFollower(followThisUserId, user);
			res.setStatus(200);
			
		} catch(Exception e) {
			res.setStatus(400);
		}
		return followers;
	}
	
	
	
	
	
	
	
	
	
	
	
	

}
