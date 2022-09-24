package com.skilldistillery.mentorme.controllers;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
			
		}
		return newReply;
	}

}
