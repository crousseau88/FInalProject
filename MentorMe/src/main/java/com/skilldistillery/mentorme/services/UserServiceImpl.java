package com.skilldistillery.mentorme.services;

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
	public User update(int userId, User user) {
		Optional<User> userOpt = userRepo.findById(userId);
		if (userOpt.isPresent() && userOpt.get().getActive()) {
			String encodedPW = encoder.encode(user.getPassword());
			User oldUser = userOpt.get();
			oldUser.setPassword(encodedPW);
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
	public boolean destroy(int userId) {
		Optional<User> userOpt = userRepo.findById(userId);
		User deactivateMe = userOpt.get();
		deactivateMe.setActive(false);
		userRepo.saveAndFlush(deactivateMe);
		return (!deactivateMe.getActive());
	}

}
