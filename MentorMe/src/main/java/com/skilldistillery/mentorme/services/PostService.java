package com.skilldistillery.mentorme.services;

import java.util.List;

import com.skilldistillery.mentorme.entities.Post;

public interface PostService {



	List<Post> showLoggedInUserPosts(String username);

	List<Post> showPostsByUserId(int userId);

	Post makePost(Post post, String username);

	Post updatePost(Post post, int postId, String username);

	boolean deletePost(int postId, String username);
	
}
