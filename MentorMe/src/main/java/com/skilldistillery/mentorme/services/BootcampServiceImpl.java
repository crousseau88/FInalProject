package com.skilldistillery.mentorme.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampAdvice;
import com.skilldistillery.mentorme.entities.BootcampReview;
import com.skilldistillery.mentorme.entities.Tool;
import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.BootcampAdviceRepository;
import com.skilldistillery.mentorme.repositories.BootcampRepository;
import com.skilldistillery.mentorme.repositories.BootcampReviewRepository;
import com.skilldistillery.mentorme.repositories.ToolRepository;
import com.skilldistillery.mentorme.repositories.UserRepository;

@Service
public class BootcampServiceImpl implements BootcampService {
	
	@Autowired
	private BootcampRepository bootRepo;
	@Autowired
	private BootcampReviewRepository bootRevRepo;
	@Autowired
	private BootcampAdviceRepository bootAdviceRepo;
	@Autowired
	private ToolRepository toolRepo;
	@Autowired
	private UserRepository userRepo;
	
	@Override
	public List<Bootcamp> getAllBootcamps(){
		List<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootRepo.findAll();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bootcamps;
		
	}
	@Override
	public List<Bootcamp> getBootcampsByUsername(String username){
		List<BootcampReview> bootcamps = null;
		List<Bootcamp> results = null;
		try {
			results = new ArrayList<>();
			bootcamps = bootRevRepo.findByUser_username(username);
			for (BootcampReview bootcampReview : bootcamps) {
				Bootcamp boot = bootcampReview.getBootcamp();
				results.add(boot);
			}
			return results;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return results;
		
	}
	@Override
	public List<BootcampReview> getBootcampReviewsByUsername(String username){
		List<BootcampReview> bootcamps = null;
		try {
			bootcamps = bootRevRepo.findByUser_username(username);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bootcamps;
		
	}
	@Override
	public Set<Bootcamp> getBootcampsByKeyword(String keyword){
		keyword = "%" + keyword + "%";
		String kw2 = "%" + keyword + "%";
		String kw3 = "%" + keyword + "%";
		Set<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootRepo.findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLikeOrBootcampTech_TechNameIgnoreCaseLike(keyword, kw2, kw3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bootcamps;
		
	}
	
	@Override
	public BootcampAdvice getBootcampAdviceByReviewId(int reviewId) {
		BootcampAdvice advice = null;
		try {
			advice = bootAdviceRepo.findByBootcampReviewId(reviewId);
			return advice;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			advice = null;
		}
		return advice;
	}
	@Override
	public List<Tool> getBootTooldByAdviceId(int adviceId) {
		List<Tool> tools = null;
		try {
			tools = toolRepo.findByBootcampAdviceId(adviceId);
			return tools;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			tools = null;
		}
		return tools;
	}
	
	@Override
	public List<BootcampReview> getBootcampReviewsByBootcampId(int bootcampId){
		List<BootcampReview> bootcamps = null;
		try {
			bootcamps = bootRevRepo.findByBootcamp_id(bootcampId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bootcamps;
		
	}
	
	@Override
	public List<BootcampReview> addABootcampReview(String username, BootcampReview review, int bootId){
		List<BootcampReview> reviews = null;
		User user = userRepo.findByUsername(username);
		Optional<Bootcamp> optBootcamp = bootRepo.findById(bootId);
		if(optBootcamp.isPresent() && user != null) {
			Bootcamp bootcamp = optBootcamp.get();
			review.setUser(user);
			bootcamp.addReview(review);
			bootRevRepo.saveAndFlush(review);
			bootRepo.saveAndFlush(bootcamp);
			reviews = bootcamp.getReviews();
			return reviews;
		}
		return reviews;
	}
	
	@Override
	public BootcampAdvice addBootcampAdvice(String username, BootcampAdvice advice, int reviewId){
		User user = userRepo.findByUsername(username);
		Optional<BootcampReview> reviewOpt = bootRevRepo.findById(reviewId);
		if(reviewOpt.isPresent()) {
			BootcampReview review = reviewOpt.get();
			advice.setBootcampReview(review);
			bootAdviceRepo.saveAndFlush(advice);
			bootRevRepo.saveAndFlush(review);
			return advice;
		}
		return null;
	}

}
