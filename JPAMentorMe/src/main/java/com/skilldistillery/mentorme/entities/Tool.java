package com.skilldistillery.mentorme.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Tool {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String name;
	
	@Column(name="tool_type")
	private String toolType;
	
	private String why;
	
	private String website;
	
	private String notes;
	
	@ManyToOne
	@JoinColumn(name="bootcamp_advice_id")
	private BootcampAdvice bootcampAdvice;

////////////////////////////////////GENERATED//////////////////////////
	public Tool() {
		super();
	}

	public BootcampAdvice getBootcampAdvice() {
		return bootcampAdvice;
	}

	public void setBootcampAdvice(BootcampAdvice bootcampAdvice) {
		this.bootcampAdvice = bootcampAdvice;
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

	public String getToolType() {
		return toolType;
	}

	public void setToolType(String toolType) {
		this.toolType = toolType;
	}

	public String getWhy() {
		return why;
	}

	public void setWhy(String why) {
		this.why = why;
	}

	public String getWebsite() {
		return website;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
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
		Tool other = (Tool) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "Tool [id=" + id + ", name=" + name + ", toolType=" + toolType + ", why=" + why + ", website=" + website
				+ ", notes=" + notes + "]";
	}
	
	
	
}
