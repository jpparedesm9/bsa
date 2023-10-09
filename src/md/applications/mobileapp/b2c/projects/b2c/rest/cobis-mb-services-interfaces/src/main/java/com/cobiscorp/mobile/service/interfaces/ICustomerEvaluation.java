package com.cobiscorp.mobile.service.interfaces;

import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.response.CustomerEvaluationResponse;

public interface ICustomerEvaluation {

	/**
	 * Realiza la evaluacion del cliente
	 * 
	 * @param curp
	 * @return evaluacion del cliente, id y monto
	 * @throws MobileServiceException
	 *             cobis-mb-services-integration
	 */

	// metodo que dentro va a estar lo de los sg
	CustomerEvaluationResponse customerEvaluationImpl(com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest customerEvaluationRequest, String cobisSessionId)
			throws MobileServiceException;

}
