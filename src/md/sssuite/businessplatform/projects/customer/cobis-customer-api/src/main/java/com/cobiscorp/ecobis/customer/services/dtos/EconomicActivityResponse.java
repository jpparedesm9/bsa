package com.cobiscorp.ecobis.customer.services.dtos;

/**
* Class to represent the table cl_actividad_ec.
* @author
**/

public class EconomicActivityResponse {

	private String code;
	private String description;
	private String sense;
	private String industry;
	private String value;
	private String status;
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSense() {
		return sense;
	}
	public void setSense(String sense) {
		this.sense = sense;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public EconomicActivityResponse(String code, String description,
			String sense, String industry, String value, String status) {
		super();
		this.code = code;
		this.description = description;
		this.sense = sense;
		this.industry = industry;
		this.value = value;
		this.status = status;
	}
	
	public EconomicActivityResponse() {
		super();
	}
	
	
	
}
