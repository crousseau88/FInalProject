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
@Table(name="reply_review")
public class ReplyReview {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private boolean helpful;
	
	private boolean inappropriate;
	
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User userReplyReview;
	
	@Column(name="flag_remarks")
	private String flagRemarks;
	
	@ManyToOne
	@JoinColumn(name = "reply_id")
	private Reply reply;

	public ReplyReview() {
		super();
	}
	
	

	public User getUserReplyReview() {
		return userReplyReview;
	}



	public void setUserReplyReview(User userReplyReview) {
		this.userReplyReview = userReplyReview;
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

	public Reply getReply() {
		return reply;
	}

	public void setReply(Reply reply) {
		this.reply = reply;
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
		ReplyReview other = (ReplyReview) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "ReplyReview [id=" + id + ", helpful=" + helpful + ", inappropriate=" + inappropriate + ", reply="
				+ reply +  ", flagRemarks=" + flagRemarks + "]";
	}

}
