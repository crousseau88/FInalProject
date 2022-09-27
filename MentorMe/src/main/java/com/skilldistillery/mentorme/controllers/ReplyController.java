package com.skilldistillery.mentorme.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.mentorme.entities.Reply;
import com.skilldistillery.mentorme.services.PostService;
import com.skilldistillery.mentorme.services.ReplyService;

@RestController
@RequestMapping(path = "api")
@CrossOrigin({ "*", "http://localhost/" })
public class ReplyController {

	@Autowired
	PostService postServ;
	@Autowired
	ReplyService replyServ;

	@GetMapping("replies/{postId}")
	public List<Reply> getRepliesForAPost(@PathVariable int postId, HttpServletResponse res) {
		List<Reply> replies = null;

		try {
			replies = replyServ.getRepliesForAPost(postId);
			res.setStatus(200);
			return replies;
		} catch (Exception e) {
			res.setStatus(404);
			e.printStackTrace();
		}

		return replies;
	}
	
	@PostMapping("replies/{postId}")
	public Reply addAReplyToAPost(@PathVariable int postId, @RequestBody Reply reply, HttpServletResponse res, Principal principal) {
		Reply newReply = null;
		try {
			newReply = replyServ.addAReplyToAPost(postId, reply, principal.getName());
			res.setStatus(200);
			return newReply;
		} catch(Exception e) {
			res.setStatus(400);
		}
		return newReply;
	}
	@DeleteMapping("replies/{postId}/{replyId}")
	public void deleteAReplyToAPost(@PathVariable int postId, @PathVariable int replyId, HttpServletResponse res, Principal principal) {
		boolean worked = false;
		try {
			worked = replyServ.removeAReplyFromAPost(postId, replyId, principal.getName());
			res.setStatus(200);
		} catch(Exception e) {
			res.setStatus(400);
		}
	}
	
	@PutMapping("replies/{postId}/{replyId}")
	public Reply updateAReply(@PathVariable int postId, @PathVariable int replyId, @RequestBody Reply reply, HttpServletResponse res, Principal principal) {
		Reply newReply = null;
		try {
			newReply = replyServ.updateAReplyOnAPost(postId, replyId, reply, principal.getName());
			res.setStatus(200);
			return newReply;
		} catch (Exception e) {
			res.setStatus(400);
			e.printStackTrace();
		}
		
		return newReply;
	}

}
