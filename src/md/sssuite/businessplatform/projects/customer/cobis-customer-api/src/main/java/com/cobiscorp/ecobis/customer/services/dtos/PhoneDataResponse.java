package com.cobiscorp.ecobis.customer.services.dtos;

import java.util.Date;

/**
* Class to represent the table cl_telefonos
* @author 
**/

public class PhoneDataResponse {
	
	
	private Integer entity;  
	private Integer address; 
	private Integer sequential;
	private String value;    
	private String typePhone; 
	private String phoneCharge;
	private String functionary;
	private String verified; 
	private Date dateSee;               
	private Date dateRegistration;           
	private Date dateModified;       
	private String area;
	public Integer getEntity() {
		return entity;
	}
	public void setEntity(Integer entity) {
		this.entity = entity;
	}
	public Integer getAddress() {
		return address;
	}
	public void setAddress(Integer address) {
		this.address = address;
	}
	public Integer getSequential() {
		return sequential;
	}
	public void setSequential(Integer sequential) {
		this.sequential = sequential;
	}

	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getTypePhone() {
		return typePhone;
	}
	public void setTypePhone(String typePhone) {
		this.typePhone = typePhone;
	}
	public String getPhoneCharge() {
		return phoneCharge;
	}
	public void setPhoneCharge(String phoneCharge) {
		this.phoneCharge = phoneCharge;
	}
	public String getFunctionary() {
		return functionary;
	}
	public void setFunctionary(String functionary) {
		this.functionary = functionary;
	}
	public String getVerified() {
		return verified;
	}
	public void setVerified(String verified) {
		this.verified = verified;
	}
	public Date getDateSee() {
		return dateSee;
	}
	public void setDateSee(Date dateSee) {
		this.dateSee = dateSee;
	}
	public Date getDateRegistration() {
		return dateRegistration;
	}
	public void setDateRegistration(Date dateRegistration) {
		this.dateRegistration = dateRegistration;
	}
	public Date getDateModified() {
		return dateModified;
	}
	public void setDateModified(Date dateModified) {
		this.dateModified = dateModified;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public PhoneDataResponse(Integer entity, Integer address,
			Integer sequential, String value, String typePhone,
			String phoneCharge, String functionary, String verified,
			Date dateSee, Date dateRegistration, Date dateModified, String area) {
		super();
		this.entity = entity;
		this.address = address;
		this.sequential = sequential;
		this.value = value;
		this.typePhone = typePhone;
		this.phoneCharge = phoneCharge;
		this.functionary = functionary;
		this.verified = verified;
		this.dateSee = dateSee;
		this.dateRegistration = dateRegistration;
		this.dateModified = dateModified;
		this.area = area;
	}
	public PhoneDataResponse() {
		super();
	}
	
	

	
}
