package com.skilldistillery.mentorme.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampReview;

public interface BootcampReviewRepository extends JpaRepository<BootcampReview, Integer>{
	
	List<BootcampReview> findByUser_username(String username);
	
	List<BootcampReview> findByBootcamp_id(int id);

}
