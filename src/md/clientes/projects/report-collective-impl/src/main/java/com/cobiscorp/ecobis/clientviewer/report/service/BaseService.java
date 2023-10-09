package com.cobiscorp.ecobis.clientviewer.report.service;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.ICOBISTS;
import com.cobiscorp.cobis.cts.dtos.ServiceRequest;
import com.cobiscorp.cobis.jaxrs.publisher.SessionManager;
import com.cobiscorp.ecobis.report.util.Util;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 *
 */
public class BaseService {
	private static final ILogger logger = LogFactory.getLogger(BaseService.class);
	protected Util util;

	public BaseService() {
		util = new Util();
	}

	/**
	 * Obtiene el ServiceRequestTO a partir del sessionId y serviceId
	 * 
	 * @param sessionId
	 * @param serviceId
	 *            id generado por el SG cuando registra la operacion
	 * @return
	 */
	protected ServiceRequestTO getHeaderRequest(String serviceId) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia getHeaderRequest");
		}
		String sessionId = SessionManager.getSessionId();
		ServiceRequest headerRequest = new ServiceRequest();
		headerRequest.addFieldInHeader(ICOBISTS.HEADER_SESSION_ID, ICOBISTS.HEADER_STRING_TYPE, sessionId);
		ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
		
		serviceReportRequestTO.addValue(ServiceRequestTO.SERVICE_HEADER, headerRequest);
		serviceReportRequestTO.setSessionId(sessionId);
		serviceReportRequestTO.setServiceId(serviceId);
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza getHeaderRequest");
		}
		return serviceReportRequestTO;
	}
}
