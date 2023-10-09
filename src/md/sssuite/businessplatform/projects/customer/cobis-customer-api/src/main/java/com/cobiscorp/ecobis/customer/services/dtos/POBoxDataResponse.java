package com.cobiscorp.ecobis.customer.services.dtos;

import java.util.Date;

/**
* Class to represent the table cl_casilla.
* @author
**/

public class POBoxDataResponse {

	private Integer entity;
	private Integer box;
	private String value;
	private String type;
	private Integer city;
	private Integer province;
	private Integer subsidiary;
	private Date registrationDate;
	private Date modifiedDate;
	private String validity;
	private String functionary;
	private String verified;
	private Date verifiedDate;
	private String empPO;	
	private String ownerBox;	
	private Integer country;
	private Integer canton;	
	private String correspondence;
	
	public POBoxDataResponse() {
		super();
	}
	public POBoxDataResponse(Integer entity, Integer box, String value,
			String type, Integer city, Integer province, Integer subsidiary,
			Date registrationDate, Date modifiedDate, String validity,
			String functionary, String verified, Date verifiedDate,
			String empPO, String ownerBox, Integer country, Integer canton,
			String correspondence) {
		super();
		this.entity = entity;
		this.box = box;
		this.value = value;
		this.type = type;
		this.city = city;
		this.province = province;
		this.subsidiary = subsidiary;
		this.registrationDate = registrationDate;
		this.modifiedDate = modifiedDate;
		this.validity = validity;
		this.functionary = functionary;
		this.verified = verified;
		this.verifiedDate = verifiedDate;
		this.empPO = empPO;
		this.ownerBox = ownerBox;
		this.country = country;
		this.canton = canton;
		this.correspondence = correspondence;
	}
	public Integer getEntity() {
		return entity;
	}
	public void setEntity(Integer entity) {
		this.entity = entity;
	}
	public Integer getBox() {
		return box;
	}
	public void setBox(Integer box) {
		this.box = box;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getCity() {
		return city;
	}
	public void setCity(Integer city) {
		this.city = city;
	}
	public Integer getProvince() {
		return province;
	}
	public void setProvince(Integer province) {
		this.province = province;
	}
	public Integer getSubsidiary() {
		return subsidiary;
	}
	public void setSubsidiary(Integer subsidiary) {
		this.subsidiary = subsidiary;
	}
	public String getValidity() {
		return validity;
	}
	public void setValidity(String validity) {
		this.validity = validity;
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

	public Date getRegistrationDate() {
		return registrationDate;
	}
	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public Date getVerifiedDate() {
		return verifiedDate;
	}
	public void setVerifiedDate(Date verifiedDate) {
		this.verifiedDate = verifiedDate;
	}
	public String getEmpPO() {
		return empPO;
	}
	public void setEmpPO(String empPO) {
		this.empPO = empPO;
	}
	public String getOwnerBox() {
		return ownerBox;
	}
	public void setOwnerBox(String ownerBox) {
		this.ownerBox = ownerBox;
	}
	public Integer getCountry() {
		return country;
	}
	public void setCountry(Integer country) {
		this.country = country;
	}
	public Integer getCanton() {
		return canton;
	}
	public void setCanton(Integer canton) {
		this.canton = canton;
	}
	public String getCorrespondence() {
		return correspondence;
	}
	public void setCorrespondence(String correspondence) {
		this.correspondence = correspondence;
	}
	
}
