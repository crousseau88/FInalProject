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

class ReplyReviewTest {

	private static EntityManagerFactory emf;
	private EntityManager em;
	private ReplyReview reply;
	
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
		reply = em.find(ReplyReview.class, 1);
	}

	@AfterEach
	void tearDown() throws Exception {
		em.close();
		reply = null;
	}

	@Test
	void test() {
		assertNotNull(reply);
		assertNotNull(reply.getUserReplyReview());
		assertNotNull(reply.getReply());
//		assertNotNull(reply.getReply());
	}
	@Test
	void test_mapping_tools() {
		assertEquals("TEST REPLY: Mentee 2 to Mentor 3", reply.getReply().getText());
		
	}
	

	
	

}
