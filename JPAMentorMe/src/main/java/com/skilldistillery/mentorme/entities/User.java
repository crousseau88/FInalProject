package com.skilldistillery.mentorme.entities;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String username;

	private String password;

	private boolean active;

	private String role;
	
	@Column(name="profile_img")
	private String profileImg;

	@Column(name = "first_name")
	private String firstName;

	@Column(name = "last_name")
	private String lastName;

	private String email;

	@Column(name = "about_me")
	private String aboutMe;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<BootcampReview> reviews;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "mentor_followers", joinColumns = @JoinColumn(name = "mentor_id"), inverseJoinColumns = @JoinColumn(name = "mentee_id"))
	private List<User> menteeFollowers;
	
	@JsonIgnore
	@ManyToMany(mappedBy="menteeFollowers")
	private List<User> mentorFollowing;
	
	@JsonIgnore
	@OneToMany(mappedBy = "sender")
	private List<DirectMessage> sentMessages;
	
	@JsonIgnore
	@OneToMany(mappedBy = "recipient")
	private List<DirectMessage> recievedMessages;
	
	@JsonIgnore
	@OneToMany(mappedBy = "userPostReview")
	private List<PostReview> postReviews;
	
	@JsonIgnore
	@OneToMany(mappedBy = "userPost")
	private List<Post> posts;
	
	@JsonIgnore
	@OneToMany(mappedBy = "userReplyReview")
	private List<ReplyReview> replyReviews;
	
	@JsonIgnore
	@OneToMany(mappedBy = "user")
	private List<Reply> replies;
	
	//////////////////////////////////// GENERATED////////////////////////////
	
	public void addFollower(User follower) {
		if(menteeFollowers == null) {
			menteeFollowers = new ArrayList<>();
		} if(!menteeFollowers.contains(follower)) {
			menteeFollowers.add(follower);
		}
	}
	public void removeFollower(User follower) {
		if (mentorFollowing != null && mentorFollowing.contains(follower)) {
			mentorFollowing.remove(follower);
		}
	}


	public User() {
		super();
	}
	
	

	public String getProfileImg() {
		return profileImg;
	}



	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}



	public List<ReplyReview> getReplyReviews() {
		return replyReviews;
	}



	public List<Reply> getReplies() {
		return replies;
	}



	public void setReplies(List<Reply> replies) {
		this.replies = replies;
	}



	public void setReplyReviews(List<ReplyReview> replyReviews) {
		this.replyReviews = replyReviews;
	}



	public List<Post> getPosts() {
		return posts;
	}



	public void setPosts(List<Post> posts) {
		this.posts = posts;
	}



	public List<PostReview> getPostReviews() {
		return postReviews;
	}



	public void setPostReviews(List<PostReview> postReviews) {
		this.postReviews = postReviews;
	}



	public List<DirectMessage> getSentMessages() {
		return sentMessages;
	}



	public void setSentMessages(List<DirectMessage> sentMessages) {
		this.sentMessages = sentMessages;
	}



	public List<DirectMessage> getRecievedMessages() {
		return recievedMessages;
	}



	public void setRecievedMessages(List<DirectMessage> recievedMessages) {
		this.recievedMessages = recievedMessages;
	}



	public List<User> getMenteeFollowers() {
		return menteeFollowers;
	}



	public void setMenteeFollowers(List<User> menteeFollowers) {
		this.menteeFollowers = menteeFollowers;
	}



	public List<User> getMentorFollowing() {
		return mentorFollowing;
	}



	public void setMentorFollowing(List<User> mentorFollowing) {
		this.mentorFollowing = mentorFollowing;
	}



	public List<BootcampReview> getReviews() {
		return reviews;
	}

	public void setReviews(List<BootcampReview> reviews) {
		this.reviews = reviews;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public boolean getActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAboutMe() {
		return aboutMe;
	}

	public void setAboutMe(String aboutMe) {
		this.aboutMe = aboutMe;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
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
		User other = (User) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", active=" + active + ", role="
				+ role + ", firstName=" + firstName + ", lastName=" + lastName + ", email=" + email + ", aboutMe="
				+ aboutMe + "]";
	}

}
