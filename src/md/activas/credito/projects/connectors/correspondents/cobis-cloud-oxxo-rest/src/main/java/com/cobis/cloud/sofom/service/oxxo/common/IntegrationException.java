package com.cobis.cloud.sofom.service.oxxo.common;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;

/**
 * @author Cesar Loachamin
 */
public class IntegrationException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	private final ServiceResponse response;

	public IntegrationException(ServiceResponse response) {
		this.response = response;
	}

	public ServiceResponse getResponse() {
		return response;
	}
}
