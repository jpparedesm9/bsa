package com.cobiscorp.ecobis.customer.services.dtos;

public class ContactDataResponse {

	private Integer entity;
	private Integer contact;
	private String name;
	private String phone;
	private String address;
	private String email;

	public ContactDataResponse(Integer entity, Integer contact, String name,
			String address, String phone, String email) {
		this.entity = entity;
		this.contact = contact;
		this.name = name;
		this.phone = phone;
		this.address = address;
		this.email = email;
	}

	public Integer getEntity() {
		return entity;
	}

	public void setEntity(Integer entity) {
		this.entity = entity;
	}

	public Integer getContact() {
		return contact;
	}

	public void setContact(Integer contact) {
		this.contact = contact;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

}
