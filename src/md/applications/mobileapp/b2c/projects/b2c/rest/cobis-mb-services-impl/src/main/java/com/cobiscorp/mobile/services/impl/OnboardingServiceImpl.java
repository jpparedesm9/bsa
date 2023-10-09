package com.cobiscorp.mobile.services.impl;

import java.util.Map;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.CustomerResponse;
import com.cobiscorp.mobile.model.OnboardingRequest;
import com.cobiscorp.mobile.response.ValidateParemeterResponse;
import com.cobiscorp.mobile.service.interfaces.IOnboardingService;
import com.cobiscorp.mobile.services.impl.utils.Constants;
import com.cobiscorp.mobile.services.impl.utils.Utils;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.parameter.dto.ParameterSearchResponse;

@Component
@Service({ IOnboardingService.class })
@Properties({ @Property(name = "service.impl", value = "current") })
public class OnboardingServiceImpl extends ServiceBase implements IOnboardingService {

	protected static final String EMPTY_COBIS_SESSION_ID = "";
	@Reference(bind = "setServiceIntegration", unbind = "unsetServiceIntegration", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ICTSServiceIntegration serviceIntegration;

	private ILogger LOGGER = LogFactory.getLogger(OnboardingServiceImpl.class);
	private static final String className = "[OnboardingServiceImpl]";
	private static final String messageActivate = "Al momento no se puede procesar la solicitud";

	@Override
	public CustomerResponse onBoardingRegister(OnboardingRequest onboardingRequest) throws MobileServiceException {
		if (LOGGER.isDebugEnabled())
			LOGGER.logInfo("Starting onboardingRegister method in class " + className);
		
		CustomerResponse customerResponse = null;
		try {
			ServiceRequestTO serviceRequest = new ServiceRequestTO();
			serviceRequest.addValue("inOnboardingCustomerRequest", Utils.getOnboardingCustomerRequest(onboardingRequest));

			ServiceResponseTO serviceResponseTO = execute(serviceIntegration, LOGGER, Constants.SERV_ONBOARDING_REGISTER, EMPTY_COBIS_SESSION_ID, serviceRequest);

			if (serviceResponseTO == null) {
				manageResponseError(serviceResponseTO, LOGGER);
			} else {
				if (serviceResponseTO.isSuccess()) {
					Map<String, Object> outputs = (Map<String, Object>) serviceResponseTO.getValue("com.cobiscorp.cobis.cts.service.response.output");
					customerResponse = new CustomerResponse(Integer.parseInt(Utils.getOutputs(outputs, "@o_ente").toString()), Integer.parseInt(Utils.getOutputs(outputs, "@o_direccion").toString()),
							Integer.parseInt(Utils.getOutputs(outputs, "@o_telefono").toString()));

				} else {
					manageResponseError(serviceResponseTO, LOGGER);
				}
			}

		} catch (Exception e) {
			if (LOGGER.isDebugEnabled())
				LOGGER.logError("Logging error of onboardingRegister method in class " + className, e);
			throw new MobileServiceException(e);
		} finally {
			if (LOGGER.isDebugEnabled())
				LOGGER.logInfo("Finishing onboardingRegister method in class " + className);
		}
		return customerResponse;
	}

	public void setServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
	}

	public void unsetServiceIntegration(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = null;
	}

	@Override
	public ValidateParemeterResponse validateResponse() throws MobileServiceException {

		ValidateParemeterResponse validate = new ValidateParemeterResponse();
		ParameterServiceImpl parameterService = new ParameterServiceImpl();
		parameterService.setServiceIntegration(serviceIntegration);

		ParameterSearchResponse activateProd = parameterService.searchParameter("APRDIG", "CLI", EMPTY_COBIS_SESSION_ID);
		String valuesActivate = "N";

		if (activateProd != null && !"".equals(activateProd.getCharValue()) && activateProd.getCharValue().equals("S")) {
			valuesActivate = "S";
		}

		LOGGER.logDebug("Parameter to activate the digital product: " + activateProd.getCharValue());
		LOGGER.logDebug("Parameter to activate the digital product: " + valuesActivate);

		validate.setStatus(valuesActivate);
		validate.setMessage(messageActivate);

		return validate;
	}

}
