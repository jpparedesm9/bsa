/**
 * 
 */
package com.cobiscorp.mobile.services.impl.utils;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.mobile.model.BaseRequest;
import com.cobiscorp.mobile.model.BaseResponse;
import com.cobiscorp.mobile.model.Message;

/**
 * @author hsalazar
 * 
 */
public class ServicesUtil {

	private static final ILogger logger = LogFactory.getLogger(ServicesUtil.class);
	private static final String CLASS_NAME = " [---> MB --->] ";
	private static final String MSG_FAIL_EXECUTION_SERVICE = CLASS_NAME + "Fallo en la ejecucion del servicio.";

	/**
	 * Obtiene un objeto ServiceRequestTO anónimo
	 * 
	 * @param serviceId
	 * @return
	 */
	public static ServiceRequestTO getHeaderAnonymousService(String serviceId) {
		return ServicesUtil.getCommonHeaderService(serviceId, "");
	}

	/**
	 * Obtiene un objeto ServiceRequestTO con sesion
	 * 
	 * @param serviceId
	 * @return
	 */
	public static ServiceRequestTO getHeaderService(String serviceId) {
		return ServicesUtil.getCommonHeaderService(serviceId, SessionManager.getSessionId());
	}

	/**
	 * Obtiene un objeto ServiceRequestTO comun para servicios anonimos y con sesion
	 * 
	 * @param serviceId
	 * @param sessionId
	 * @return
	 */
	private static ServiceRequestTO getCommonHeaderService(String serviceId, String sessionId) {
		ServiceRequest header = new ServiceRequest();
		header.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO requestTO = new ServiceRequestTO();
		requestTO.addValue(ServiceRequestTO.SERVICE_HEADER, header);
		requestTO.setSessionId(sessionId);
		requestTO.setServiceId(serviceId);
		return requestTO;
	}

	/**
	 * Permite administrar mensajes que provinen desde los servicios *
	 * 
	 * @param responseService
	 * @param request
	 * @param response
	 */
	public static void manageMessages(ServiceResponseTO responseTO, BaseRequest request, BaseResponse response) {
		if (logger.isDebugEnabled()) {
			logger.logDebug(MSG_FAIL_EXECUTION_SERVICE);
		}
		response.setSuccess(false);
		Message messageResponse = MessagesUtil.getMessage(responseTO, request.getCulture());
		response.setMessage(messageResponse);
		MessagesUtil.logMessages(messageResponse);
	}
}
