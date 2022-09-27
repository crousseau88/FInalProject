package com.skilldistillery.mentorme.repositories;

import java.util.Set;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.Bootcamp;

public interface BootcampRepository extends JpaRepository<Bootcamp, Integer>{
	
	Set<Bootcamp> findByNameIgnoreCaseLikeOrDescriptionIgnoreCaseLikeOrBootcampTech_TechNameIgnoreCaseLike(String keyword, String keyword1, String keyword2);

}
