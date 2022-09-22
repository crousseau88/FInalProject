package com.skilldistillery.mentorme.entities;

import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;

@Entity
public class ReplyReview {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private boolean helpful;
	
	private boolean inappropriate;
	
	private Reply reply;
	
	private User user;
	
	@JoinColumn(name="flag_remarks")
	private String flagRemarks;

	public ReplyReview() {
		super();
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
				+ reply + ", user=" + user + ", flagRemarks=" + flagRemarks + "]";
	}

}
