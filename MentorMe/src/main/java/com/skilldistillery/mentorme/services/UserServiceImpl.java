package com.skilldistillery.mentorme.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.UserRepository;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepo;
	@Autowired
	private PasswordEncoder encoder;
	@Autowired
	private AuthService authServ;



	
	@Override
	public User show(int userId) {
		Optional<User> optUser = userRepo.findById(userId);
		if (optUser.isPresent()) {
			User user = optUser.get();
			return user;
		} else {
			return null;
		}
	}

	@Override
	public User update(String username, User user) {
		User oldUser = userRepo.findByUsername(username);
		if (oldUser != null && oldUser.getActive()) {
			oldUser.setAboutMe(user.getAboutMe());
			oldUser.setRole(user.getRole());
			oldUser.setFirstName(user.getFirstName());
			oldUser.setLastName(user.getLastName());
			oldUser.setEmail(user.getEmail());
			oldUser.setProfileImg(user.getProfileImg());
			userRepo.saveAndFlush(oldUser);
			return oldUser;
		}

		return null;
	}

	@Override
	public boolean destroy(String username) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			user.setActive(false);
			userRepo.saveAndFlush(user);
		}
		return (!user.getActive());
	}
	
	@Override
	public List<User> getUsersFollowers(String username){
		User user = userRepo.findByUsername(username);
		List<User> followers = null;
		if(user != null) {
			followers = userRepo.getUsersBymenteeFollowers(user);
		}
		return followers;
	}
	@Override
	public List<User> getUsersFollowing(String username){
		User user = userRepo.findByUsername(username);
		List<User> following = null;
		if(user != null) {
			following = userRepo.getUsersBymentorFollowing(user);
		}
		return following;
	}
	
	@Override
	public List<User> addAFollower(int followingId, User follower){
		Optional<User> followMe = userRepo.findById(followingId);
		if(followMe.isPresent()) {
			User follow = followMe.get();
			follow.addFollower(follower);
			userRepo.saveAndFlush(follow);
			List<User> followers = getUsersFollowers(follow.getUsername());
			return followers;
		}
		return null;
	}

}
