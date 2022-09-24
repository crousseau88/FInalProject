package com.skilldistillery.mentorme.entities;

import java.util.List;
import java.util.Objects;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="bootcamp_advice")
public class BootcampAdvice {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String title;
	
	private String advice;
	
	@OneToOne
	@JoinColumn(name = "bootcamp_review_id")
	private BootcampReview bootcampReview;
	
	@JsonIgnore
	@OneToMany(mappedBy="bootcampAdvice")
	private List<Tool> tools;

////////////////////////////////////////GENERATED//////////////////////////
	public BootcampAdvice() {
		super();
	}
	
	

	public List<Tool> getTools() {
		return tools;
	}



	public void setTools(List<Tool> tools) {
		this.tools = tools;
	}



	public BootcampReview getBootcampReview() {
		return bootcampReview;
	}



	public void setBootcampReview(BootcampReview bootcampReview) {
		this.bootcampReview = bootcampReview;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAdvice() {
		return advice;
	}

	public void setAdvice(String advice) {
		this.advice = advice;
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
		BootcampAdvice other = (BootcampAdvice) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "BootcampAdvice [id=" + id + ", title=" + title + ", advice=" + advice + "]";
	}
	
	

}
