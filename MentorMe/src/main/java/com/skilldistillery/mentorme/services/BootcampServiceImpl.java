package com.skilldistillery.mentorme.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampReview;
import com.skilldistillery.mentorme.repositories.BootcampRepository;
import com.skilldistillery.mentorme.repositories.BootcampReviewRepository;

@Service
public class BootcampServiceImpl implements BootcampService {
	
	@Autowired
	private BootcampRepository bootRepo;
	@Autowired
	private BootcampReviewRepository bootRevRepo;
	
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
	public List<Bootcamp> getBootcampsByKeyword(String keyword){
		keyword = "%" + keyword + "%";
		String kw2 = "%" + keyword + "%";
		String kw3 = "%" + keyword + "%";
		List<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootRepo.findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLikeOrBootcampTech_TechNameIgnoreCaseLike(keyword, kw2, kw3);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bootcamps;
		
	}

}
