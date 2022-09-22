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

class BootcampAdviceTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BootcampAdvice bootcamp;
	
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
		bootcamp = em.find(BootcampAdvice.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bootcamp = null;
	}

	@Test
	void test() {
		assertNotNull(bootcamp);
		assertEquals("TEST TITLE 1", bootcamp.getTitle());
	}
	@Test
	void test_mapping_tools() {
		assertNotNull(bootcamp);
		assertTrue(bootcamp.getTools().size() > 1);
	}
	@Test
	void test_mapping_review() {
		assertNotNull(bootcamp.getBootcampReview());
		assertEquals("Mentor 3: TEST REVIEW of SD", bootcamp.getBootcampReview().getBootcampReview());
	
	}

	
	

}
