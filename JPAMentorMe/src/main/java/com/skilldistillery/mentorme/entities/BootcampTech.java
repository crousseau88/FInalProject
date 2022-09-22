package com.skilldistillery.mentorme.entities;

import java.util.Objects;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="bootcamp_tech")
public class BootcampTech {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	@Column(name="tech_name")
	private String techName;

	////////////////////////////GENERATED/////////////////////////
	
	public int getId() {
		return id;
	}

	public BootcampTech() {
		super();
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTechName() {
		return techName;
	}

	public void setTechName(String techName) {
		this.techName = techName;
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
		BootcampTech other = (BootcampTech) obj;
		return id == other.id;
	}

	@Override
	public String toString() {
		return "BootcampTech [id=" + id + ", techName=" + techName + "]";
	}
	
	

}
