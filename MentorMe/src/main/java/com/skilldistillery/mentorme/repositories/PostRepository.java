package com.skilldistillery.mentorme.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.Post;

public interface PostRepository extends JpaRepository<Post, Integer>{
	
	List<Post> findPostsByUserPost_Username(String username);
	List<Post> findPostsByUserPost_Id(Integer userId);

}
