package com.cobiscorp.ecobis.cloud.service.dto.client;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class ComplementaryDataResponse {
	
	private ServiceResponse complementary;

	public ComplementaryDataResponse() {
	}

	public ComplementaryDataResponse(ServiceResponse complementary) {
		super();
		this.complementary = complementary;
	}

	public ServiceResponse getComplementary() {
		return complementary;
	}

	public void setComplementary(ServiceResponse complementary) {
		this.complementary = complementary;
	}

}
