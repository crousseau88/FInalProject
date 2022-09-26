package com.skilldistillery.mentorme.services;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Post;
import com.skilldistillery.mentorme.entities.Reply;
import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.PostRepository;
import com.skilldistillery.mentorme.repositories.ReplyRepository;
import com.skilldistillery.mentorme.repositories.UserRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepo;
	@Autowired
	UserRepository userRepo;
	@Autowired
	PostRepository postRepo;
	
	@Override
	public List<Reply> getRepliesForAPost(int postId){
		List<Reply> replies = replyRepo.findByPost_Id(postId);
		List<Reply> results = new ArrayList<>();
		for (Reply reply : replies) {
			if(reply.getEnabled()) {
				results.add(reply);
			}

		}
		return results;
	}
	
	@Override
	public Reply addAReplyToAPost(int postId, Reply reply, String username) {
		User user = userRepo.findByUsername(username);
		Optional<Post> postOpt = postRepo.findById(postId);
		if(postOpt.isPresent() && user != null) {
			Post post = postOpt.get();
			reply.setEnabled(true);
			reply.setUser(user);
			post.addReply(reply);
			replyRepo.saveAndFlush(reply);
			postRepo.saveAndFlush(post);
			return reply;
		}
		
		return null;
	}
	@Override
	public boolean removeAReplyFromAPost(int postId, int replyId, String username) {
		User user = userRepo.findByUsername(username);
		Optional<Reply> replyOpt = replyRepo.findById(replyId);
		if(replyOpt.isPresent() && replyOpt.get().getUser() == user) {
			Reply reply = replyOpt.get();
			Optional<Post> postOpt = postRepo.findById(postId);
			postOpt.get().removeReply(reply);
			replyRepo.delete(reply);
			
			if(postOpt.isPresent()) {
				Post post = postOpt.get();
				postRepo.saveAndFlush(post);
				return !post.getReplies().contains(reply);
			}
		}
		
		
		return false;
	}
	@Override
	public Reply updateAReplyOnAPost(int postId, int replyId, Reply reply, String username) {
		User user = userRepo.findByUsername(username);
		Optional<Reply> replyOpt = replyRepo.findById(replyId);
		if(replyOpt.isPresent() && replyOpt.get().getUser() == user) {
			Reply oldReply = replyOpt.get();
			Optional<Post> postOpt = postRepo.findById(postId);
			if(postOpt.isPresent()) {
				Post post = postOpt.get();
				oldReply.setText(reply.getText());
				oldReply.setUpdated(LocalDateTime.now());
				postRepo.saveAndFlush(post);
				replyRepo.saveAndFlush(oldReply);
				return oldReply;
			}
		}
		
		
		return null;
	}
}
