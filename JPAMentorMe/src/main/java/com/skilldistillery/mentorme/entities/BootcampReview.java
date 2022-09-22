package com.skilldistillery.mentorme.entities;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
	private int curriculumRating;
	
	@Column(name="instructor_rating")
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

/////////////////////////////////////////GENERATED/////////////////////
	public BootcampReview() {
		super();
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

	public int getCurriculumRating() {
		return curriculumRating;
	}

	public void setCurriculumRating(int curriculumRating) {
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
