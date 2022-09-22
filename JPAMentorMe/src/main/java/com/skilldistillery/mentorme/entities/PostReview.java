package com.skilldistillery.mentorme.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
@Entity
public class PostReview {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	
	private User user;
	
	private Post post;
	
	private boolean helpful;
	
	private boolean inappropriate;
	
	@JoinColumn(name="flag_remarks")
	private String flagRemarks;

	public PostReview() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public boolean isHelpful() {
		return helpful;
	}

	public void setHelpful(boolean helpful) {
		this.helpful = helpful;
	}

	public boolean isInappropriate() {
		return inappropriate;
	}

	public void setInappropriate(boolean inappropriate) {
		this.inappropriate = inappropriate;
	}

	public String getFlagRemarks() {
		return flagRemarks;
	}

	public void setFlagRemarks(String flagRemarks) {
		this.flagRemarks = flagRemarks;
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
		PostReview other = (PostReview) obj;
		return id == other.id;
	}
	
	
}
