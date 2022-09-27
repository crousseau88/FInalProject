package com.skilldistillery.mentorme.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampAdvice;
import com.skilldistillery.mentorme.entities.BootcampReview;
import com.skilldistillery.mentorme.entities.Tool;
import com.skilldistillery.mentorme.repositories.BootcampAdviceRepository;
import com.skilldistillery.mentorme.repositories.BootcampRepository;
import com.skilldistillery.mentorme.repositories.BootcampReviewRepository;
import com.skilldistillery.mentorme.repositories.ToolRepository;

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

}
