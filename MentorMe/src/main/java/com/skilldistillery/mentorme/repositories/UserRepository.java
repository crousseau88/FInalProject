package com.skilldistillery.mentorme.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.User;

public interface UserRepository extends JpaRepository<User, Integer> {
	User getUserById(int userId);
	User findByUsername(String username);
	List<User> getUsersBymenteeFollowers(User user);
	List<User> getUsersBymentorFollowing(User user);
}
