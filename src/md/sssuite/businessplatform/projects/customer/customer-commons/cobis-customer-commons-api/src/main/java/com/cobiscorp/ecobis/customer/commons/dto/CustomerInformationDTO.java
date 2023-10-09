package com.cobiscorp.ecobis.customer.commons.dto;

import java.util.HashMap;

public class CustomerInformationDTO {

	private HashMap<String, Object> clientInformation = new HashMap<String, Object>();

	public HashMap<String, Object> getClientInformation() {
		return clientInformation;
	}

	public void setClientInformation(HashMap<String, Object> clientInformation) {
		this.clientInformation = clientInformation;
	}

	
}
