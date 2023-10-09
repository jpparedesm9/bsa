package com.cobiscorp.mobile.model;

public class CustomerResponse {

	private Integer entityId;
	private Integer addressId;
	private Integer phoneId;
	private String curp;
	
	public CustomerResponse(){}

	public CustomerResponse(Integer entityId, Integer addressId, Integer phoneId) {
		super();
		this.entityId = entityId;
		this.addressId = addressId;
		this.phoneId = phoneId;
	}

	public Integer getEntityId() {
		return entityId;
	}

	public void setEntityId(Integer entityId) {
		this.entityId = entityId;
	}

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public Integer getPhoneId() {
		return phoneId;
	}

	public void setPhoneId(Integer phoneId) {
		this.phoneId = phoneId;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

}
