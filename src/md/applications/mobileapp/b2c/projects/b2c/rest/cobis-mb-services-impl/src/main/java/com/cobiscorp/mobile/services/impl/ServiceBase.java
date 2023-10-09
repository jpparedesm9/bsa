package com.cobiscorp.mobile.services.impl;

import java.util.Iterator;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.mobile.exception.MobileServiceException;
import com.cobiscorp.mobile.services.impl.security.COBISSecurityManager;
import com.cobiscorp.mobile.services.impl.security.SessionSecurityKey;
import com.cobiscorp.mobile.services.impl.security.dto.CTSServiceResponseTO;

import cobiscorp.ecobis.commons.dto.MessageTO;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ServiceBase {

	private static final String MESSAGE_ERROR_CODE = "0001";
	private static final String MESSAGE_ERROR_MESSAGE = "Application Error";

	protected static final String EMPTY_COBIS_SESSION_ID = "";
	protected static final String DEFAULT_CACHE_NAME = "IndividualLoanCache";

	protected ServiceResponseTO execute(ICTSServiceIntegration serviceIntegration, ILogger logger, String serviceId, String cobisSessionId, ServiceRequestTO serviceRequest)
			throws MobileServiceException {
		try {
			logger.logDebug("Inicia Execute");
			if(cobisSessionId == null || "".equals(cobisSessionId)){
				cobisSessionId = getCobisSessionId(serviceIntegration, logger);
			}
			ServiceRequest header = new ServiceRequest();
			header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, cobisSessionId);
			serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
			serviceRequest.setSessionId(cobisSessionId);
			serviceRequest.setServiceId(serviceId);
			return serviceIntegration.getResponseFromCTS(serviceRequest);
		} catch (Exception e) {
			logger.logDebug("Error en EXECUTE: ", e);
			throw new MobileServiceException(e);
		}
	}
	
	protected String getCobisSessionId(ICTSServiceIntegration serviceIntegration, ILogger logger) {
		String sessionId = null;
		
		if(SessionManager.getSessionId() != null){
			sessionId = SessionManager.getSessionId();
		} else {
			SessionSecurityKey wSessionSecurityKey = new SessionSecurityKey();
			CTSServiceResponseTO response = new CTSServiceResponseTO();
	        COBISSecurityManager.ClearSessionId(wSessionSecurityKey);
	        sessionId = COBISSecurityManager.initializeSession(serviceIntegration, wSessionSecurityKey, response);
	        //request.getSession().setAttribute("cobis-session-id", sessionId);
			if(sessionId == null){
				if (logger.isErrorEnabled()) {
	                logger.logError(response);
	            }
	            throw new COBISInfrastructureRuntimeException("It is not possible to initialize a new COBIS Session");
			}
		}
		return sessionId;
		
	}

	@SuppressWarnings("rawtypes")
	public void manageResponseError(ServiceResponseTO serviceResponse, ILogger logger) throws MobileServiceException {
		if (serviceResponse != null && serviceResponse.getMessages().size() > 0) {
			MobileServiceException exception = new MobileServiceException();
			for (Iterator iterator = serviceResponse.getMessages().iterator(); iterator.hasNext();) {
				MessageTO message = (MessageTO) iterator.next();
				if(!message.getCode().equals("0")){
					exception.addError(message.getCode(), message.getMessage());
				}
			}
			throw exception;
		} else {
			throw new MobileServiceException(MESSAGE_ERROR_CODE, MESSAGE_ERROR_MESSAGE);
		}
	}

	protected void manageResponseError(ILogger logger, MessageTO... messages) throws MobileServiceException {
		if (messages != null && messages.length > 0) {
			MobileServiceException exception = new MobileServiceException();
			for (MessageTO message : messages) {
				exception.addError(message.getCode(), message.getMessage());
			}
			throw exception;
		} else {
			throw new MobileServiceException(MESSAGE_ERROR_CODE, MESSAGE_ERROR_MESSAGE);
		}
	}

	public ServiceRequestTO fillServiceRequestTO(ServiceRequestTO serviceRequest, ILogger logger, String cobisSessionId) {
		ServiceRequest header = new ServiceRequest();
		logger.logInfo("Session id: " + cobisSessionId);
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, cobisSessionId);
		serviceRequest.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		serviceRequest.setSessionId(cobisSessionId);
		return serviceRequest;
	}

}
