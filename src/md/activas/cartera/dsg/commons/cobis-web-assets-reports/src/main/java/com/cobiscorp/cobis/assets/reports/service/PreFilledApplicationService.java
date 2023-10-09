package com.cobiscorp.cobis.assets.reports.service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.assets.reports.commons.Util;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.PreFilledApplicationRequest;
import cobiscorp.ecobis.assets.cloud.dto.PreFilledApplicationResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

/* 			ESTA CLASE QUEDA INACTIVA DEBIDO A QUE YA NO EXISTE LA PANTALLA
 *          DE LLAMADO LOS FUENTES DEL JASPER FUERON MOVIDOS AL NOTIFICADOR 
 *          QUE ES DONDE SE ESTAN USANDO ACTUALMENTE */

/**
 * Clase utilizada llamar a los servicios generados por SG
 * 
 * @author CobisCorp
 * 
 */
public class PreFilledApplicationService extends BaseService {
	private static final ILogger logger = LogFactory.getLogger(AccountStatusService.class);
	Util util = new Util();

	/***
	 * Informacion Solicitud Prellenada
	 * 
	 * @param
	 * @param
	 * @param
	 * @return List PreFilledApplicationService
	 */

	public PreFilledApplicationResponse[] searchPreFilledApplication(PreFilledApplicationRequest preFilledApplicationRequest, ICTSServiceIntegration serviceIntegration) throws Exception{

		logger.logDebug("----->>>Inicio PreFilledApplicationService -- searchPreFilledApplication");
		ServiceResponseTO serviceResponseTo = null;
		try {

			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_SEARCH_PREFILLEDAPLICATION);
			serviceReportRequestTO.getData().put(ConstantValue.IN_PREFILLEDAPLICATION, preFilledApplicationRequest);

			serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo != null) {
				if (serviceResponseTo.isSuccess()) {
					PreFilledApplicationResponse[] preFilledApplicationResponse = (PreFilledApplicationResponse[]) serviceResponseTo.getValue(ConstantValue.RETURN_PREFILLEDAPLICATION);
					return preFilledApplicationResponse;
				} else {
					if (logger.isDebugEnabled())
						logger.logDebug("Error ejecucion servicio searchPreFilledApplication");
					util.error(serviceResponseTo);
				}
			}
		} catch (Exception ex) {
			if (logger.isDebugEnabled())
				logger.logError("Error en " + ConstantValue.SERVICE_SEARCH_PREFILLEDAPLICATION, ex);
			util.error(serviceResponseTo);
		} finally {
			if (logger.isDebugEnabled())
				logger.logDebug("Finaliza " + ConstantValue.SERVICE_SEARCH_PREFILLEDAPLICATION);
		}
		return null;
	}

}
