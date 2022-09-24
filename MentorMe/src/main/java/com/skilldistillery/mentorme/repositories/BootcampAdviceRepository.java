package com.skilldistillery.mentorme.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.BootcampAdvice;

public interface BootcampAdviceRepository extends JpaRepository<BootcampAdvice, Integer>{

	BootcampAdvice findByBootcampReviewId(int reviewId);
}
