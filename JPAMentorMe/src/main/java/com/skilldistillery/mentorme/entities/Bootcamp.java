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
public class Bootcamp {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	private String website;
	
	@Column(name="image_url")
	private String imageUrl;
	
	@Column(name="length_weeks")
	private int lengthWeeks;
	
	private String description;
	
	@JsonIgnore
	@ManyToMany
	@JoinTable(name = "bootcamp_tech_joiner", joinColumns = @JoinColumn(name = "bootcamp_id"), inverseJoinColumns = @JoinColumn(name = "bootcamp_tech_id"))
	private List<BootcampTech> bootcampTech;

	@JsonIgnore
	@OneToMany(mappedBy = "bootcamp")
	private List<BootcampReview> reviews;
	
/////////////////////////////GENERATED///////////////////////////////
	public Bootcamp() {
		super();
	}
	public void addReview(BootcampReview review) {
		if(reviews == null) {
			reviews = new ArrayList<>();
		} if(!reviews.contains(review)) {
			reviews.add(review);
			review.setBootcamp(this);
			review.setReviewDate(LocalDateTime.now());
		}
	}
	public void removeReply(BootcampReview review) {
		if (reviews != null && reviews.contains(review)) {
			reviews.remove(review);
		}
	}


	public List<BootcampReview> getReviews() {
		return reviews;
	}


	public void setReviews(List<BootcampReview> reviews) {
		this.reviews = reviews;
	}


	public List<BootcampTech> getBootcampTech() {
		return bootcampTech;
	}


	public void setBootcampTech(List<BootcampTech> bootcampTech) {
		this.bootcampTech = bootcampTech;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getWebsite() {
		return website;
	}


	public void setWebsite(String website) {
		this.website = website;
	}


	public String getImageUrl() {
		return imageUrl;
	}


	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}


	public int getLengthWeeks() {
		return lengthWeeks;
	}


	public void setLengthWeeks(int lengthWeeks) {
		this.lengthWeeks = lengthWeeks;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
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
		Bootcamp other = (Bootcamp) obj;
		return id == other.id;
	}


	@Override
	public String toString() {
		return "Bootcamp [id=" + id + ", name=" + name + ", website=" + website + ", imageUrl=" + imageUrl
				+ ", lengthWeeks=" + lengthWeeks + ", description=" + description + "]";
	}
	
	
	
}
