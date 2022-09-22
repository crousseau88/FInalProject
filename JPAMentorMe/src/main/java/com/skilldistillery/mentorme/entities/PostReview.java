package com.skilldistillery.mentorme.entities;



import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name = "post_review")
public class PostReview {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private boolean helpful;

	private boolean inappropriate;

	@Column(name = "flag_remarks")
	private String flagRemarks;
	
	@ManyToOne
	@JoinColumn(name = "user_id")
	private User userPostReview;
	
	@ManyToOne
	@JoinColumn(name = "post_id")
	private Post post;

	public PostReview() {
		super();
	}

	public User getUserPostReview() {
		return userPostReview;
	}

	public void setUserPostReview(User userPostReview) {
		this.userPostReview = userPostReview;
	}

	public Post getPost() {
		return post;
	}

	public void setPost(Post post) {
		this.post = post;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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
