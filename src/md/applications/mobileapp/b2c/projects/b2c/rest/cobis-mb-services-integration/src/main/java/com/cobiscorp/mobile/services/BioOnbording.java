package com.cobiscorp.mobile.services;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Properties;
import org.apache.felix.scr.annotations.Property;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.ReferenceCardinality;
import org.apache.felix.scr.annotations.Service;

import com.cobiscorp.b2c.jwt.CobisJwt;
import com.cobiscorp.b2c.jwt.InvalidTokenException;
import com.cobiscorp.b2c.jwt.ShakeJwtKeyGenerator;
import com.cobiscorp.b2c.jwt.TokenExpiredException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.model.BankGeolocation;
import com.cobiscorp.mobile.model.Client;
import com.cobiscorp.mobile.model.RenapoClientRequest;
import com.cobiscorp.mobile.request.FingerPrintRequest;
import com.cobiscorp.mobile.request.FingerprintBiometricRequest;
import com.cobiscorp.mobile.request.TopicRequest;
import com.cobiscorp.mobile.rest.interfaces.IRestBioOnbording;
import com.cobiscorp.mobile.service.interfaces.IBioOnbording;
import com.cobiscorp.mobile.service.interfaces.IConfigurationService;
import com.cobiscorp.mobile.util.BankGeolocationUtil;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

@Path("/channels/mobilebanking")
@Component
@Service({ IRestBioOnbording.class })
@Properties({ @Property(name = "service.impl", value = "integration") })
public class BioOnbording extends RestServiceBase implements IRestBioOnbording {

	private final ILogger logger = LogFactory.getLogger(BioOnbording.class);

	// Referencias
	@Reference(bind = "setBioOnbording", unbind = "unsetBioOnbording", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IBioOnbording bioOnbording;

	@Reference(bind = "setConfigurationService", unbind = "unsetConfigurationService", cardinality = ReferenceCardinality.MANDATORY_UNARY)
	private IConfigurationService configurationService;

	// Consumo de renapo por curp

	@POST
	@Path("renapo/curp")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response queryRenapoByCurp(@Valid RenapoClientRequest clientRequest, @Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/renapo/curp >> " + clientRequest);

		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/renapo/curp >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/renapo/curp >> cobisSessionId " + cobisSessionId);

			return successResponse(bioOnbording.generateQuery(clientRequest, cobisSessionId), cobisJwt);

		} catch (TokenExpiredException e) {

			logger.logError("Error2 al ejecutar queryRenapoByCurp" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error2 al ejecutar queryRenapoByCurp" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar queryRenapoByCurp" + e);
			return errorResponse(e.getMessage());

		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al consultar a renapo");
		}

	}

	// Consumo de servicio finger id (biomovil) para generar token opaco y devolver
	// una url

	@POST
	@Path("capture/fingerprint")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response fingerprintCapture(@Valid FingerPrintRequest fingerPrintRequest, @Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/capture/fingerprint >> " + fingerPrintRequest);
		CobisJwt cobisJwt;
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/capture/fingerprint >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/capture/fingerprint >> cobisSessionId " + cobisSessionId);
			return successResponse(bioOnbording.fingerprintCapture(fingerPrintRequest, cobisSessionId), cobisJwt);

		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar fingerprintCapture" + e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error2 al ejecutar fingerprintCapture" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error3 al ejecutar fingerprintCapture" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al capturar huellas");
		}

	}

	// Consumo de servicio finger id (biomovil) para validar después de haber tomado
	// las huellas

	@POST
	@Path("validate/fingerprint")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response fingerprintBiometricValidation(@Valid FingerprintBiometricRequest fingerBiometricRequest, @Context HttpServletRequest httpRequest) {

		logger.logDebug("/channels/mobilebanking/validate/fingerprint >> " + fingerBiometricRequest);
		CobisJwt cobisJwt;
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			logger.logDebug("/channels/mobilebanking/validate/fingerprint >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/validate/fingerprint >> cobisSessionId " + cobisSessionId);

			BankGeolocation aBankGeoloc = BankGeolocationUtil.getBankGeolocDto(cobisJwt, "SOLCO", BankGeolocationUtil.POST_TYPE, clientId);
			serviceResponse = this.configurationService.registerBankGeolocation(aBankGeoloc);
			if (serviceResponse.isSuccess()) {
				return successResponse(bioOnbording.fingerprintCaptureValidation(fingerBiometricRequest, cobisSessionId), cobisJwt);
			} else {
				logger.logError("Error Geolocalization: " + serviceResponse.getMessages());
				return errorResponse("" + serviceResponse.getMessages());
			}

		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar fingerprintBiometricValidation" + e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error2 al ejecutar fingerprintBiometricValidation" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error3 al ejecutar fingerprintBiometricValidation" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al capturar huellas");
		}
	}

	@POST
	@Path("orchestation/onboarding")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response execBioOnboarding(@Valid Client clientInformation, @Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/orchestation/onboarding >> " + clientInformation);
		CobisJwt cobisJwt;
		ServiceResponseTO serviceResponse = new ServiceResponseTO();
		try {
			cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			String clientId = cobisJwt.getAttribute(JWT_TOKEN_CUSTOMER_ID_KEY);
			logger.logDebug("/channels/mobilebanking/orchestation/onboarding >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/orchestation/onboarding >> cobisSessionId " + cobisSessionId);

			BankGeolocation aBankGeoloc = BankGeolocationUtil.getBankGeolocDto(cobisJwt, "GENIP", BankGeolocationUtil.POST_TYPE, clientId.toString());
			serviceResponse = this.configurationService.registerBankGeolocation(aBankGeoloc);
			if (serviceResponse.isSuccess()) {
				return successResponse(bioOnbording.executeBioOnboarding(clientInformation, cobisSessionId), cobisJwt);
			} else {
				logger.logError("Error Geolocalization: " + serviceResponse.getMessages());
				return errorResponse("" + serviceResponse.getMessages());
			}

		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar execBioOnboarding" + e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error2 al ejecutar execBioOnboarding" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error3 al ejecutar execBioOnboarding" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al validar Biometrico");
		}
	}

	@POST
	@Path("/managequeue/ocrmsg")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response recieveOCRMsg(@Valid TopicRequest topicRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/mq/ocrmsg >> ");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/mq/ocrmsg >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/mq/ocrmsg >> cobisSessionId " + cobisSessionId);
			return successResponse(bioOnbording.recieveOCRMsg(topicRequest, cobisSessionId), cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar fingerprintCapture" + e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error2 al ejecutar fingerprintCapture" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error3 al ejecutar fingerprintCapture" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al consultar informacion OCR");
		}
	}

	@POST
	@Path("/managequeue/scoresmsg")
	@Consumes({ "application/json" })
	@Produces({ "application/json" })
	public Response recieveSCORESMsg(@Valid TopicRequest topicRequest, @Context HttpServletRequest httpRequest) {
		logger.logDebug("/channels/mobilebanking/mq/scoresmsg >> ");
		try {
			CobisJwt cobisJwt = new CobisJwt(httpRequest.getHeader(AUTHORIZATION), new ShakeJwtKeyGenerator());
			logger.logDebug("/channels/mobilebanking/mq/scoresmsg >> CobisJwt " + cobisJwt);
			String cobisSessionId = cobisJwt.getAttribute(JWT_TOKEN_COBIS_SESSION_ID_KEY);
			logger.logDebug("/channels/mobilebanking/mq/scoresmsg >> cobisSessionId " + cobisSessionId);
			return successResponse(bioOnbording.recieveSCORESMsg(topicRequest, cobisSessionId), cobisJwt);
		} catch (MobileServiceException e) {
			logger.logError("Error1 al ejecutar recieveSCORESMsg" + e);
			return errorResponse(e);
		} catch (TokenExpiredException e) {
			logger.logError("Error2 al ejecutar recieveSCORESMsg" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (InvalidTokenException e) {
			logger.logError("Error3 al ejecutar recieveSCORESMsg" + e);
			return unauthorizedResponse(e.getMessage());
		} catch (Throwable e) {
			logger.logError("Error Throwable: ", e);
			return errorResponse("Error al consultar informacion SCORES");
		}
	}

	protected void setBioOnbording(IBioOnbording bioOnbording) {
		this.bioOnbording = bioOnbording;
	}

	protected void unsetBioOnbording(IBioOnbording bioOnbording) {
		this.bioOnbording = null;
	}

	public void setConfigurationService(IConfigurationService configurationService) {
		this.configurationService = configurationService;
	}

	public void unsetConfigurationService(IConfigurationService configurationService) {
		this.configurationService = null;
	}

}
