package com.skilldistillery.mentorme.services;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skilldistillery.mentorme.entities.Reply;
import com.skilldistillery.mentorme.entities.User;
import com.skilldistillery.mentorme.repositories.ReplyRepository;
import com.skilldistillery.mentorme.repositories.UserRepository;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	ReplyRepository replyRepo;
	@Autowired
	UserRepository userRepo;
	
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
		
		
		return reply;
	}
}
