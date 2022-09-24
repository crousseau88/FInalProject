package com.skilldistillery.mentorme.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.skilldistillery.mentorme.entities.Tool;

public interface ToolRepository extends JpaRepository<Tool, Integer>{
	List<Tool> findByBootcampAdviceId(int adviceId);
}
