package com.skilldistillery.mentorme.services;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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
		List<Post> results = new ArrayList<>();
		if (posts != null) {
			for (Post post : posts) {
				if(post.isEnabled()) {
					results.add(post);
				}
			}
			return results;
		} else {
			return null;
		}
	}

	@Override
	public List<Post> showPostsByUserId(int userId) {
		List<Post> posts = postRepo.findPostsByUserPost_Id(userId);
		List<Post> results = new ArrayList<>();
		if (posts != null) {
			for (Post post : results) {
				if(post.isEnabled()) {
					results.add(post);
				}
			}
			return results;
		} 
		else {
			return null;
		}
	}

	@Override
	public Post makePost(Post post, String username) {
		User user = userRepo.findByUsername(username);
		if (user != null) {
			post.setUserPost(user);
			post.setEnabled(true);
			post.setCreated(LocalDateTime.now());
			return postRepo.saveAndFlush(post);
		} else {
			return null;
		}
	}

	@Override
	public Post updatePost(Post post, int postId, String username) {
		User user = userRepo.findByUsername(username);
		Optional<Post> postOpt = postRepo.findById(postId);
		if (user == postOpt.get().getUserPost()) {

			if (postOpt.isPresent() && user != null) {
				Post oldPost = postOpt.get();
				oldPost.setUserPost(user);
				oldPost.setText(post.getText());
				oldPost.setSubject(post.getSubject());
				oldPost.setUpdated(LocalDateTime.now());
				oldPost.setEnabled(true);
				postRepo.saveAndFlush(oldPost);
				return oldPost;
			}
		} else {
			return null;
		}
		return null;
	}

	@Override
	public boolean deletePost(int postId, String username) {
		User user = userRepo.findByUsername(username);
		Optional<Post> postOpt = postRepo.findById(postId);
		if (user == postOpt.get().getUserPost() || user.getRole().equals("ADMIN")) {
			if (postOpt.isPresent() && postOpt.get().isEnabled()) {
				Post post = postOpt.get();
				post.setEnabled(false);
				postRepo.saveAndFlush(post);
				return (!post.isEnabled());
			}
		}
		return false;
	}

}
