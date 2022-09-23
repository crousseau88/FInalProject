package com.skilldistillery.mentorme.controllers;

import java.util.List;
import java.util.TreeSet;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mentorme.entities.Bootcamp;
import com.skilldistillery.mentorme.entities.BootcampReview;
import com.skilldistillery.mentorme.services.BootcampService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost/" })
public class BootcampController {
	
	@Autowired
	private BootcampService bootServ;
	
	
	@GetMapping("bootcamps")
	public List<Bootcamp> getAllBootcamps(HttpServletResponse res){
		List<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootServ.getAllBootcamps();
			res.setStatus(200);
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}
		return bootcamps;
	}
	@GetMapping("bootcamps/{username}")
	public List<Bootcamp> getBootcampByUsername(@PathVariable String username, HttpServletResponse res){
		List<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootServ.getBootcampsByUsername(username);
			res.setStatus(200);
			return bootcamps;
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}
		return bootcamps;
	}
	@GetMapping("bootcamps/reviews/{username}")
	public List<BootcampReview> getBootcampReviewsByUsername(@PathVariable String username, HttpServletResponse res){
		List<BootcampReview> bootcamps = null;
		try {
			bootcamps = bootServ.getBootcampReviewsByUsername(username);
			res.setStatus(200);
			return bootcamps;
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}
		return bootcamps;
	}
	@GetMapping("bootcamps/search/{keyword}")
	public List<Bootcamp> getBootcampsByKeyword(@PathVariable String keyword, HttpServletResponse res){
		List<Bootcamp> bootcamps = null;
		try {
			bootcamps = bootServ.getBootcampsByKeyword(keyword);
			res.setStatus(200);
			return bootcamps;
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}
		return bootcamps;
	}
	

}
