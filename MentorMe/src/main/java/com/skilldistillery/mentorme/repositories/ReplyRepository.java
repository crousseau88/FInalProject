package com.skilldistillery.mentorme.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.Reply;

public interface ReplyRepository extends JpaRepository<Reply, Integer>{
	
	List<Reply> findByPost_Id(int postId);

}
