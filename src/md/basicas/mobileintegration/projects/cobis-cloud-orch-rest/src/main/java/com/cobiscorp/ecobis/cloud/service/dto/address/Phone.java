package com.cobiscorp.ecobis.cloud.service.dto.address;

import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneResponse;

/**
 * @author Cesar Loachamin
 */
public class Phone {

	public static final String HOME_PHONE_TYPE = "D";
	public static final String CELL_PHONE_TYPE = "C";
	private int phoneId;
	private String number;
	private String areaCode;
	private String verifyPhone;

	public Phone() {
	}

	public int getPhoneId() {
		return phoneId;
	}

	public void setPhoneId(int phoneId) {
		this.phoneId = phoneId;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getVerifyPhone() {
		return verifyPhone;
	}

	public void setVerifyPhone(String verifyPhone) {
		this.verifyPhone = verifyPhone;
	}

	public TelephoneRequest toHomePhoneRequest(int customerId, int addressId) {
		return createRequest(customerId, addressId, HOME_PHONE_TYPE);
	}

	public TelephoneRequest toHomePhoneRequest(int customerId, int addressId, int telephoneId) {
		TelephoneRequest request = toHomePhoneRequest(customerId, addressId);
		request.setSecuencial(telephoneId);
		return request;
	}

	public TelephoneRequest toCellPhoneRequest(int customerId, int addressId) {
		return createRequest(customerId, addressId, CELL_PHONE_TYPE);
	}

	public TelephoneRequest toCellPhoneRequest(int customerId, int addressId, int telephoneId) {
		TelephoneRequest request = toCellPhoneRequest(customerId, addressId);
		request.setSecuencial(telephoneId);
		return request;
	}

	private TelephoneRequest createRequest(int customerId, int addressId, String type) {
		TelephoneRequest request = new TelephoneRequest();
		request.setCustomerId(customerId);
		request.setAddress(addressId);
		request.setValue(getNumber());
		request.setAreaCode(getAreaCode());
		request.setTypeTelephone(type);
		request.setVerifyPhone(getVerifyPhone());
		return request;
	}

	public static Phone fromResponse(TelephoneResponse telephone) {
		if (telephone == null) {
			return null;
		}
		Phone phone = new Phone();
		phone.phoneId = telephone.getTelephoneId();
		phone.number = telephone.getNumber();
		phone.areaCode = telephone.getCodeArea();
		phone.verifyPhone = telephone.getVerification();
		return phone;
	}
}
