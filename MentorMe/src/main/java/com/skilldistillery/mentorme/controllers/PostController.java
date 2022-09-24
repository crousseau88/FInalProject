package com.skilldistillery.mentorme.controllers;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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

import com.skilldistillery.mentorme.entities.Post;
import com.skilldistillery.mentorme.repositories.PostRepository;
import com.skilldistillery.mentorme.services.PostService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost/" })
public class PostController {

	@Autowired
	PostService postServ;
	@Autowired
	PostRepository postRepo;

	@GetMapping("posts")
	public List<Post> getAllPosts(HttpServletResponse res) {
		List<Post> posts = null;
		List<Post> results = new ArrayList<>();
		try {
			posts = postRepo.findAll();
			for (Post post : posts) {
				if(post.isEnabled()) {
					results.add(post);
				}
			}
			res.setStatus(200);
			return results;
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}

		return null;
	}


	@GetMapping("account/posts")
	public List<Post> getLoggedInUserPosts(HttpServletRequest req, HttpServletResponse res, Principal principal) {
		List<Post> posts = postServ.showLoggedInUserPosts(principal.getName());
		if (posts == null) {
			res.setStatus(404);
			return null;
		}
		return posts;
	}

	@GetMapping("posts/{username}")
	public List<Post> getUsersPosts(HttpServletRequest req, HttpServletResponse res, @PathVariable String username) {

		List<Post> posts = null;
		try {
			posts = postServ.showLoggedInUserPosts(username);
		} catch (Exception e) {
			res.setStatus(400);

			e.printStackTrace();
		}
		return posts;
	}
	@GetMapping("posts/user/{userId}")
	public List<Post> getUsersPosts(HttpServletRequest req, HttpServletResponse res, @PathVariable int userId) {
		
		List<Post> posts = null;
		try {
			posts = postServ.showPostsByUserId(userId);
		} catch (Exception e) {
			res.setStatus(400);
			
			e.printStackTrace();
		}
		return posts;
	}

	@PostMapping("posts")
	public Post create(HttpServletRequest req, HttpServletResponse res, @RequestBody Post post, Principal principal) {
		Post newPost = null;
		try {
			newPost = postServ.makePost(post, principal.getName());
			res.setStatus(201);
			return newPost;

		} catch (Exception e) {
			// TODO Auto-generated catch block
			res.setStatus(400);
			e.printStackTrace();
		}
		return null;
	}

	@PutMapping("posts/{postId}")
	public Post update(HttpServletRequest req, HttpServletResponse res, @PathVariable int postId, @RequestBody Post post, Principal principal) {
		Post updatedPost = null;
		try {
			updatedPost = postServ.updatePost(post, postId, principal.getName());
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		return updatedPost;
	}

	@DeleteMapping("posts/{postId}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, @PathVariable int postId,
			Principal principal) {
		try {
			boolean worked = postServ.deletePost(postId, principal.getName());
			res.setStatus(204);
			if(!worked) {
				res.setStatus(400);
			}
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}

	}

}
