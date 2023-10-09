package com.cobiscorp.ecobis.cloud.service.dto.address;

import cobiscorp.ecobis.customerdatamanagement.dto.AddressResp;

public class EmailAddress {

	private int addressId;
	private String email;
	private String verifyEmail;

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getVerifyEmail() {
		return verifyEmail;
	}

	public void setVerifyEmail(String verifyEmail) {
		this.verifyEmail = verifyEmail;
	}

	public static EmailAddress fromResponse(AddressResp response) {
		EmailAddress obj = new EmailAddress();
		obj.addressId = response.getAddress();
		obj.email = response.getAddressDesc();
		obj.verifyEmail = response.getVerification();
		return obj;
	}
}
