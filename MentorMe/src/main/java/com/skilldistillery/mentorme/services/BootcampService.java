package com.skilldistillery.mentorme.services;

import java.util.List;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampAdvice;
import com.skilldistillery.mentorme.entities.BootcampReview;
import com.skilldistillery.mentorme.entities.Tool;

public interface BootcampService {

	List<Bootcamp> getAllBootcamps();

	List<Bootcamp> getBootcampsByUsername(String username);

	List<BootcampReview> getBootcampReviewsByUsername(String username);

	List<Bootcamp> getBootcampsByKeyword(String keyword);

	BootcampAdvice getBootcampAdviceByReviewId(int reviewId);

	List<Tool> getBootTooldByAdviceId(int advice);

}
