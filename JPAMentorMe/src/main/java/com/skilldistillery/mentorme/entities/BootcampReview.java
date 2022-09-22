package com.skilldistillery.mentorme.entities;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;
@Entity
@Table(name="bootcamp_review")
public class BootcampReview {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="overall_rating")
	private int overallRating;
	
	@Column(name="curriculum_rating")
	private Integer curriculumRating;
	
	@Column(name="instructors_rating")
	private int instructorRating;
	
	@Column(name="job_assistance_rating")
	private int jobAssistanceRating;
	
	@Column(name="graduation_date")
	private Date graduationDate;
	
	@Column(name="bootcamp_review")
	private String bootcampReview;
	
	@Column(name="review_date")
	@CreationTimestamp
	private LocalDateTime reviewDate;
	
	@ManyToOne
	@JoinColumn(name="bootcamp_id")
	private Bootcamp bootcamp;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	

/////////////////////////////////////////GENERATED/////////////////////
	public BootcampReview() {
		super();
	}

	
	public User getUser() {
		return user;
	}


	public void setUser(User user) {
		this.user = user;
	}


	public Bootcamp getBootcamp() {
		return bootcamp;
	}


	public void setBootcamp(Bootcamp bootcamp) {
		this.bootcamp = bootcamp;
	}


	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOverallRating() {
		return overallRating;
	}

	public void setOverallRating(int overallRating) {
		this.overallRating = overallRating;
	}

	public Integer getCurriculumRating() {
		return curriculumRating;
	}

	public void setCurriculumRating(Integer curriculumRating) {
		this.curriculumRating = curriculumRating;
	}

	public int getInstructorRating() {
		return instructorRating;
	}

	public void setInstructorRating(int instructorRating) {
		this.instructorRating = instructorRating;
	}

	public int getJobAssistanceRating() {
		return jobAssistanceRating;
	}

	public void setJobAssistanceRating(int jobAssistanceRating) {
		this.jobAssistanceRating = jobAssistanceRating;
	}

	public Date getGraduationDate() {
		return graduationDate;
	}

	public void setGraduationDate(Date graduationDate) {
		this.graduationDate = graduationDate;
	}

	public String getBootcampReview() {
		return bootcampReview;
	}

	public void setBootcampReview(String bootcampReview) {
		this.bootcampReview = bootcampReview;
	}

	public LocalDateTime getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(LocalDateTime reviewDate) {
		this.reviewDate = reviewDate;
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
		BootcampReview other = (BootcampReview) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "BootcampReview [id=" + id + ", overallRating=" + overallRating + ", curriculumRating="
				+ curriculumRating + ", instructorRating=" + instructorRating + ", jobAssistanceRating="
				+ jobAssistanceRating + ", graduationDate=" + graduationDate + ", bootcampReview=" + bootcampReview
				+ ", reviewDate=" + reviewDate + "]";
	} 
	
	
}
