package com.skilldistillery.mentorme.services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Post;
import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.PostRepository;
import com.skilldistillery.mentorme.repositories.UserRepository;

@Service
public class PostServiceImpl implements PostService {
	
	@Autowired
	PostRepository postRepo;
	@Autowired
	UserRepository userRepo;
	
	@Override
	public List<Post> showLoggedInUserPosts(String username) {
		List<Post> posts = postRepo.findPostsByUserPost_Username(username);
		if (posts != null) {
			return posts;
		}else {
			return null;
		}
	}
	@Override
	public List<Post> showPostsByUserId(int userId) {
		List<Post> posts = postRepo.findPostsByUserPost_Id(userId);
		if (posts != null) {
			return posts;
		}else {
			return null;
		}
	}
	
	@Override
	public Post makePost(Post post, String username) {
		User user = userRepo.findByUsername(username);
		if(user != null) {
			post.setUserPost(user);			
			return postRepo.saveAndFlush(post);
		}else {
			return null;
		}
	}

}
