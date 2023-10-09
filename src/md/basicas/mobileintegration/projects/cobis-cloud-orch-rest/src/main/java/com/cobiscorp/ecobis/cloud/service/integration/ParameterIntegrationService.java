package com.cobiscorp.ecobis.cloud.service.integration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.cloud.service.util.RestServiceBase;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchRequest;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

public class ParameterIntegrationService extends RestServiceBase {
	private final ILogger logger = LogFactory.getLogger(OfficerIntegrationService.class);

	private final String className = "[OfficerIntegrationService] ";

	public ParameterIntegrationService(ICTSServiceIntegration integration) {
		super(integration);
	}

	public ParameterSearchResponse searchParameter(String nemonic, String product) throws BusinessException {
		logger.logInfo("start searchParameter");
		ParameterSearchRequest paramRequest = new ParameterSearchRequest();
		paramRequest.setNemonic(nemonic);
		paramRequest.setProduct(product);

		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue("inParameterSearchRequest", paramRequest);

		ServiceResponse serviceResponse = this.execute("Parameter.SearchParameterService.SearchByNemonicAndProduct", requestTO);

		ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
		ParameterSearchResponse[] responses = (ParameterSearchResponse[]) serviceResponseTO.getValue("returnParameterSearchResponse");
		return responses != null && responses.length > 0 ? responses[0] : new ParameterSearchResponse();
	}
}
