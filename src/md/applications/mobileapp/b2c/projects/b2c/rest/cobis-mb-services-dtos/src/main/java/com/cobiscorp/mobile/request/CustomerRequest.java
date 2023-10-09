package com.cobiscorp.mobile.request;

public class CustomerRequest {

	private Integer customerId;

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	@Override
	public String toString() {
		return "CustomerRequest [customerId=" + customerId + "]";
	}

}
