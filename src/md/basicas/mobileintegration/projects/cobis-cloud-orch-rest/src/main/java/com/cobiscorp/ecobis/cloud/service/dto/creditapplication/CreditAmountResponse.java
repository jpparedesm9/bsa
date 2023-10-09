package com.cobiscorp.ecobis.cloud.service.dto.creditapplication;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

public class CreditAmountResponse {

	private ServiceResponse serviceResponse;
	private String tasa;

	public ServiceResponse getServiceResponse() {
		return serviceResponse;
	}

	public void setServiceResponse(ServiceResponse serviceResponse) {
		this.serviceResponse = serviceResponse;
	}

	public String getTasa() {
		return tasa;
	}

	public void setTasa(String tasa) {
		this.tasa = tasa;
	}

}
