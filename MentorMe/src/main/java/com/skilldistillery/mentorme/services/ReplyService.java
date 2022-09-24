package com.skilldistillery.mentorme.services;

import java.util.List;

import com.skilldistillery.mentorme.entities.Reply;

public interface ReplyService {

	List<Reply> getRepliesForAPost(int postId);

	Reply addAReplyToAPost(int postId, Reply reply, String username);

}
