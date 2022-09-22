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

class BootcampTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private Bootcamp bootcamp;
	
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
		bootcamp = em.find(Bootcamp.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		bootcamp = null;
	}

	@Test
	void test() {
		assertNotNull(bootcamp);
		assertEquals("Skill Distillery", bootcamp.getName());
	}
	@Test
	void test_mapping_tech() {
		assertNotNull(bootcamp.getBootcampTech());
		assertTrue(bootcamp.getBootcampTech().size() > 1);
	}
	@Test
	void test_mapping_reviews() {
		assertNotNull(bootcamp.getReviews());
		assertTrue(bootcamp.getReviews().size() > 1);
	}
	
	

}
