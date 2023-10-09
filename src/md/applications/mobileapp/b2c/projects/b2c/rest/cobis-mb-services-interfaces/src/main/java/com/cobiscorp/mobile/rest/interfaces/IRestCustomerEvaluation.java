package com.cobiscorp.mobile.rest.interfaces;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Response;

import com.cobiscorp.mobile.request.CustomerRequest;

public interface IRestCustomerEvaluation {

	// los metodos para la movil cobis-mb-services-integration
	public Response customerEvaluation(
			com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest customerEvaluationRequest,
			HttpServletRequest httpRequest);

}
