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

class BootcampReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private BootcampReview bootcamp;
	
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
		bootcamp = em.find(BootcampReview.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bootcamp = null;
	}

	@Test
	void test() {
		assertNotNull(bootcamp);
		assertEquals(5, bootcamp.getInstructorRating());
	}
	@Test
	void test_mapping_bootcamp_entity() {
		assertNotNull(bootcamp.getBootcamp());
		assertEquals("Skill Distillery", bootcamp.getBootcamp().getName());
	}
	@Test
	void test_mapping_user() {
		assertNotNull(bootcamp.getUser());
		assertEquals(3, bootcamp.getUser().getId());
	
	}

	
	

}
