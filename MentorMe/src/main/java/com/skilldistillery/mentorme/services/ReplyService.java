package com.skilldistillery.mentorme.services;

import java.util.List;

import com.skilldistillery.mentorme.entities.Reply;

public interface ReplyService {

	List<Reply> getRepliesForAPost(int postId);

	Reply addAReplyToAPost(int postId, Reply reply, String username);

	boolean removeAReplyFromAPost(int postId, int replyId, String username);

	Reply updateAReplyOnAPost(int postId, int replyId, Reply reply, String username);

}
