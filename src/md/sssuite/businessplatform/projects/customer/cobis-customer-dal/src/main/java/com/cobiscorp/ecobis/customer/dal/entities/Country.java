package com.cobiscorp.ecobis.customer.dal.entities;

import java.lang.Integer;
import java.lang.String;

import javax.persistence.*;

/**
 * Entity implementation class for Entity: Country
 * @author jmoreta
 */
@NamedQueries({@NamedQuery(name = "Country.getNationalityByCode", query = "SELECT new com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse(c.countryId,c.description,c.abbreviation,c.nationality,c.status,c.continent) from Country c WHERE c.countryId = :countryId AND c.status =\"V\""),
			@NamedQuery(name = "Country.getNationalityAll", query = "SELECT new com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse(c.countryId,c.description,c.abbreviation,c.nationality,c.status,c.continent) from Country c WHERE c.status =\"V\"")})
@Entity
@Table(name = "cl_pais", schema = "cobis")
public class Country {

	@Id
	@Column(name = "pa_pais")	
	Integer countryId;
	@Column(name = "pa_descripcion")
	String description;
	@Column(name = "pa_abreviatura")
	String abbreviation;
	@Column(name = "pa_nacionalidad")
	String nationality;
	@Column(name = "pa_estado")
	String status;
	@Column(name = "pa_continente")
	String continent;	

	public Country() {
		super();
	}

	public Integer getCountryId() {
		return countryId;
	}

	public void setCountryId(Integer countryId) {
		this.countryId = countryId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAbbreviation() {
		return abbreviation;
	}

	public void setAbbreviation(String abbreviation) {
		this.abbreviation = abbreviation;
	}

	public String getNationality() {
		return nationality;
	}

	public void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getContinent() {
		return continent;
	}

	public void setContinent(String continent) {
		this.continent = continent;
	}
	
   
}
