package com.cobiscorp.ecobis.customer.services.dtos;

/**
 * DTO class : Country
 * @author jmoreta
 */
public class NationalityResponse {

	public NationalityResponse() {
		super();
	}
	
	private Integer countryId;
	private String description;
	private String abbreviation;
	private String nationality;
	private String status;
	private String continent;
	
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
	/**
	 * @param countryId
	 * @param description
	 * @param abbreviation
	 * @param nationality
	 * @param status
	 * @param continent
	 */
	public NationalityResponse(Integer countryId, String description,
			String abbreviation, String nationality, String status,
			String continent) {
		super();
		this.countryId = countryId;
		this.description = description;
		this.abbreviation = abbreviation;
		this.nationality = nationality;
		this.status = status;
		this.continent = continent;
	}
	
	
	

}
