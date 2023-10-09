package com.cobiscorp.ecobis.customer.services.dtos;
/**
* Class to represent the table cl_actividad_principal
* @author 
**/

public class MainActivityResponse {
	
	private String code;
	private String description;
	private String business;
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
	public String getBusiness() {
		return business;
	}

	public void setBusiness(String business) {
		this.business = business;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
	public MainActivityResponse(String code, String description,
			String business, String status) {
		super();
		this.code = code;
		this.description = description;
		this.business = business;
		this.status = status;
	}
	public MainActivityResponse(){
	
		super();
     
	}
 
}
