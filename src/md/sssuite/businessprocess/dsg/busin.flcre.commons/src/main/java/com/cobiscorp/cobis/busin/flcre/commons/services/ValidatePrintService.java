package com.cobiscorp.cobis.busin.flcre.commons.services;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.credit.report.validation.dto.ValidationRequest;
import cobiscorp.ecobis.credit.report.validation.dto.ValidationResponse;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.busin.flcre.commons.constants.RequestName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ReturnName;
import com.cobiscorp.cobis.busin.flcre.commons.constants.ServiceId;
import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.busin.flcre.commons.utiles.MessageManagement;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ValidatePrintService extends BaseEvent {

	private static final ILogger logger = LogFactory.getLogger(ValidatePrintService.class);

	public ValidatePrintService(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	/***
	 * CONSULTA LOS PARAMETROS GENERALES (# DE IMPRESIONES Y ESTADO DE OPERACION) PARA VALIDACION DE IMPRESION
	 * 
	 * @param tramitNum
	 * @param serviceId
	 * @return
	 */
	public ValidationResponse getValidatePrint(int tramitNum, ICommonEventArgs arg1, BehaviorOption options) {
		try {

			logger.logDebug(" *****-- INICIO SERVICIO DE VALIDACION -- # TRAMITE " + tramitNum);

			if (tramitNum != 0) {

				ValidationRequest validationRequest = new ValidationRequest();
				ServiceRequestTO serviceReportRequestTO = new ServiceRequestTO();
				ServiceResponse serviceResponseValidation = null;
				ServiceResponseTO serviceResponseValidationTO = null;

				validationRequest.setTramite(tramitNum);
				serviceReportRequestTO.getData().put(RequestName.IN_VALIDATION_REQUEST_PRINT, validationRequest);
				serviceResponseValidation = execute(getServiceIntegration(), logger, ServiceId.SERVICE_VALIDATION_PRINT, serviceReportRequestTO);

				logger.logDebug("*****-- RESULTADO DE SERVICIO DE VALIDACION --" + serviceResponseValidation);

				if (serviceResponseValidation != null && serviceResponseValidation.isResult()) {
					serviceResponseValidationTO = (ServiceResponseTO) serviceResponseValidation.getData();
					logger.logDebug("OBJETO RETURN ------->" + serviceResponseValidationTO.getValue(ReturnName.RETURN_VALIDATION_PRINT));
					return (ValidationResponse) serviceResponseValidationTO.getValue(ReturnName.RETURN_VALIDATION_PRINT);

				} else {
					MessageManagement.show(serviceResponseValidation, arg1, options);
				}
			}
			return null;
		} catch (Exception ex) {
			logger.logError("Error", ex);
			return null;
		}
	}

}
