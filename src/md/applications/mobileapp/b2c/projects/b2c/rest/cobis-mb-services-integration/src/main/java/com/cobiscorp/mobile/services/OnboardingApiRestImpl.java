package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.Constants;
import com.cobiscorp.mobile.model.Credentials;
import com.cobiscorp.mobile.model.CustomerResponse;
import com.cobiscorp.mobile.model.EnrollDevicelClient;
import com.cobiscorp.mobile.model.OnboardingRequest;
import com.cobiscorp.mobile.response.ValidateParemeterResponse;
import com.cobiscorp.mobile.rest.interfaces.IRestOnboardingService;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.service.interfaces.IOnboardingService;
import com.cobiscorp.mobile.service.interfaces.IRegistrationService;
import com.cobiscorp.mobile.service.interfaces.ISecurityService;
import com.cobiscorp.mobile.util.SecurityUtil;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestOnboardingService.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class OnboardingApiRestImpl extends RestServiceBase implements IRestOnboardingService {

	@Reference(bind = "setOnboardingService", unbind = "unsetOnboardingService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IOnboardingService onboardingService;

	@Reference(bind = "setRegistrationService", unbind = "unsetRegistrationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IRegistrationService registrationService;

	@Reference(bind = "setSecurityService", unbind = "unsetSecurityService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private ISecurityService securityService;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	@POST
	@Path("/onboarding/register")
	@Consumes({ MediaType.APPLICATION_JSON })
	public Response register(@Valid OnboardingRequest onboardingRequest, @Context HttpServletRequest httpRequest) {
		try {
			if (logger.isDebugEnabled()) {
				logger.logDebug("/channels/mobilebanking/onboarding/register ==> POST");
				logger.logDebug("onboardingRequest>>" + onboardingRequest);
			}

			ValidateParemeterResponse validateParemterActivate = onboardingService.validateResponse();

			// Se valida si el parametro se encuentra habilitado para permitir iniciar el flujo
			if (validateParemterActivate.getStatus().equals("N")) {
				return errorResponse(validateParemterActivate.getMessage());
			}

			CobisJwt cobisJwt = new CobisJwt(new ShakeJwtKeyGenerator());
			CustomerResponse customerResponse = onboardingService.onBoardingRegister(onboardingRequest);

			if (customerResponse == null || customerResponse.getEntityId() == null) {
				return errorResponse("Error al realizar el registro");
			}

			// TODO: Validate sms key
			// Enroll onboarding customer
			String phoneNumber = onboardingRequest.getCellphoneNumber();
			Integer clientId = customerResponse.getEntityId();

			EnrollDevicelClient enrollDevicelClient = new EnrollDevicelClient();
			enrollDevicelClient.setPhoneNumber(phoneNumber);
			enrollDevicelClient.setPassword(phoneNumber);
			enrollDevicelClient.setChannel(Constants.CHANNEL);
			enrollDevicelClient.setClientId(clientId);
			enrollDevicelClient.setBrandDevice(onboardingRequest.getBrandDevice());
			enrollDevicelClient.setModelDevice(onboardingRequest.getModelDevice());
			enrollDevicelClient.setVersionOS(onboardingRequest.getVersionOS());
			enrollDevicelClient.setCarrier(onboardingRequest.getCarrier());
			enrollDevicelClient.setConnectAddress(onboardingRequest.getConnectAddress());
			registrationService.enrollClient(enrollDevicelClient, false);

			// Login onboarding customer
			Credentials credentials = new Credentials();
			credentials.setUsername(phoneNumber);
			credentials.setPassword(phoneNumber);
			credentials.setCulture(Constants.CULTURE);
			credentials.setConnectAddress(onboardingRequest.getConnectAddress());
			credentials.setDevice(onboardingRequest.getDevice());
			return SecurityUtil.setResponse(credentials, cobisJwt, false, true, configurationService, securityService, logger);

		} catch (MobileServiceException e) {
			logger.logError(e);
			return errorResponse(e);
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al realizar el registro");
		}
	}

	public void setOnboardingService(IOnboardingService onboardingService) {
		this.onboardingService = onboardingService;
	}

	public void unsetOnboardingService(IOnboardingService onboardingService) {
		this.onboardingService = null;
	}

	public void setRegistrationService(IRegistrationService registrationService) {
		this.registrationService = registrationService;
	}

	public void unsetRegistrationService(IRegistrationService registrationService) {
		this.registrationService = null;
	}

	protected void setSecurityService(ISecurityService securityService) {
		this.securityService = securityService;
	}

	protected void unsetSecurityService(ISecurityService securityService) {
		this.securityService = null;
	}

	protected void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	protected void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

}
