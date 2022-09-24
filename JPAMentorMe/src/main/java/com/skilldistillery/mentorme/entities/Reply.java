package com.skilldistillery.mentorme.entities;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
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

@Entity
public class Reply {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="reply")
	private String text;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User user;
	
	@CreationTimestamp
	private LocalDateTime created;
	
	@UpdateTimestamp
	private LocalDateTime updated;
	
	private Boolean enabled;
	
	@ManyToOne
	@JoinColumn(name = "post_id")
	private Post post;
	
	//Does this need to exist?
	@ManyToOne
	@JoinColumn(name="reply_id")
	private Reply reply;
	
	@JsonIgnore
	@OneToMany(mappedBy = "reply")
	private List<Reply> replies;
	
	@JsonIgnore
	@OneToMany(mappedBy = "reply")
	private List<ReplyReview> replyReviews;


	public Reply() {
		super();
	}


	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public List<ReplyReview> getReplyReviews() {
		return replyReviews;
	}


	public void setReplyReviews(List<ReplyReview> replyReviews) {
		this.replyReviews = replyReviews;
	}


	public List<Reply> getReplies() {
		return replies;
	}


	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}


	public Post getPost() {
		return post;
	}


	public void setPost(Post post) {
		this.post = post;
	}


	public Reply getReply() {
		return reply;
	}


	public void setReply(Reply reply) {
		this.reply = reply;
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


	public Boolean getEnabled() {
		return enabled;
	}


	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}


	public Reply getReplyId() {
		return reply;
	}


	public void setReplyId(Reply reply) {
		this.reply = reply;
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
		Reply other = (Reply) obj;
		return id == other.id;
	}


	@Override
	public String toString() {
		return "Reply [id=" + id + ", text=" + text + ", created=" + created
				+ ", updated=" + updated + ", enabled=" + enabled + ", replyId=" + reply + "]";
	}
	
}
