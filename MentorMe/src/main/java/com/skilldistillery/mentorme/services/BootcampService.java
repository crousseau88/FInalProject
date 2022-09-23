package com.skilldistillery.mentorme.services;

import java.util.List;
import java.util.TreeSet;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampReview;

public interface BootcampService {

	List<Bootcamp> getAllBootcamps();

	List<Bootcamp> getBootcampsByUsername(String username);

	List<BootcampReview> getBootcampReviewsByUsername(String username);

	List<Bootcamp> getBootcampsByKeyword(String keyword);

}
