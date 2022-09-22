package com.skilldistillery.mentorme.entities;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

class ToolTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Tool tool;
	
	@BeforeAll
	static void setUpBeforeClass() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAMentorMe");
	}

	@AfterAll
	static void tearDownAfterClass() throws Exception {
		emf.close();
	}

	@BeforeEach
	void setUp() throws Exception {
		em = emf.createEntityManager();
		tool = em.find(Tool.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		tool = null;
	}

	@Test
	void test() {
		assertNotNull(tool);
//		assertNotNull(tool.getBootcampAdvice());
	}
	@Test
	void test_mapping_tools() {
		assertEquals("TEST TOOL 1 of 2 FOR REVIEW 1", tool.getName());
		
	}
	

	
	

}
