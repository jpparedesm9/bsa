package com.cobiscorp.mobile.model;

public class AddressResponse {

	private Integer addressId;
	private Integer customerId;

	public Integer getAddressId() {
		return addressId;
	}

	public void setAddressId(Integer addressId) {
		this.addressId = addressId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("AddressResponse [");
		sb.append("addressId=");
		sb.append(addressId == null ? "" : addressId);
		sb.append(", customerId=");
		sb.append(customerId == null ? "" : customerId);
		return sb.toString();
	}

}
