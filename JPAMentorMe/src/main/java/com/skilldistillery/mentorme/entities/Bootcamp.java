package com.skilldistillery.mentorme.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

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

	
/////////////////////////////GENERATED///////////////////////////////
	public Bootcamp() {
		super();
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
