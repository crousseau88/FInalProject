package com.skilldistillery.mentorme.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
public class Post {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String text;
	
	@CreationTimestamp
	private LocalDateTime created;
	
	@UpdateTimestamp
	private LocalDateTime updated;
	
	private boolean enabled;
	
	private String subject;
	
	@JsonIgnore
	@OneToMany(mappedBy = "post")
	private List<PostReview> postReviews;
	
	@JsonIgnoreProperties({"post"})
	@OneToMany(mappedBy = "post")
	private List<Reply> replies;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User userPost;

	public Post() {
		super();
	}
	public void addReply(Reply reply) {
		if(replies == null) {
			replies = new ArrayList<>();
		} if(!replies.contains(reply)) {
			replies.add(reply);
			reply.setCreated(LocalDateTime.now());
			reply.setPost(this);
		}
	}
	public void removeReply(Reply reply) {
		if (replies != null && replies.contains(reply)) {
			replies.remove(reply);
			reply.setEnabled(false);
		}
	}

	public List<Reply> getReplies() {
		return replies;
	}



	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}



	public User getUserPost() {
		return userPost;
	}



	public void setUserPost(User userPost) {
		this.userPost = userPost;
	}



	public List<PostReview> getPostReviews() {
		return postReviews;
	}



	public void setPostReviews(List<PostReview> postReviews) {
		this.postReviews = postReviews;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public LocalDateTime getCreated() {
		return created;
	}

	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	public LocalDateTime getUpdated() {
		return updated;
	}

	public void setUpdated(LocalDateTime updated) {
		this.updated = updated;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	@Override
	public int hashCode() {
		return Objects.hash(id);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Post other = (Post) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Post [id=" + id + ", text=" + text + ", created=" + created + ", updated=" + updated + ", enabled="
				+ enabled + ", subject=" + subject + "]";
	}
	
}
