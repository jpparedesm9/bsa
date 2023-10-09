package com.cobiscorp.mobile.services.impl;

import java.util.ArrayList;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchRequest;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.ConfigParameter;
import com.cobiscorp.mobile.service.interfaces.IParameterService;

@Component
@Service({ IParameterService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class ParameterServiceImpl extends ServiceBase implements IParameterService{
	private final ILogger LOGGER = LogFactory.getLogger(ParameterServiceImpl.class);

	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	public ArrayList<ConfigParameter> getParameters(String cobisSessionId) throws MobileServiceException {
		
		// ELAVON
		ParameterSearchResponse companyElavon = searchParameter("WPPCOM", "CLI", cobisSessionId);
		

		LOGGER.logDebug("/cobis-cloud/mobile/parameters ELACOM" + companyElavon.getCharValue());
		
		ArrayList<ConfigParameter> parameters = new ArrayList<ConfigParameter>();

		ConfigParameter parameter = new ConfigParameter();
		// ELAVON
		parameter = new ConfigParameter();
		parameter.setKey("ELAVON_COMPANY");// Elavon Company
		parameter.setValue(companyElavon.getCharValue()); //
		parameters.add(parameter);


		return parameters;

	}

	public ParameterSearchResponse searchParameter(String nemonic, String product, String cobisSessionId) throws MobileServiceException {
		LOGGER.logInfo("start searchParameter");
		ParameterSearchRequest paramRequest = new ParameterSearchRequest();
		paramRequest.setNemonic(nemonic);
		paramRequest.setProduct(product);

		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue("inParameterSearchRequest", paramRequest);

		ServiceResponseTO serviceResponseTO = this.execute(serviceIntegration, LOGGER, "Parameter.SearchParameterService.SearchByNemonicAndProduct", cobisSessionId, requestTO);

		ParameterSearchResponse[] responses = (ParameterSearchResponse[]) serviceResponseTO.getValue("returnParameterSearchResponse");
		return responses != null && responses.length > 0 ? responses[0] : new ParameterSearchResponse();
	}
	
	protected void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}
	
	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}
}
