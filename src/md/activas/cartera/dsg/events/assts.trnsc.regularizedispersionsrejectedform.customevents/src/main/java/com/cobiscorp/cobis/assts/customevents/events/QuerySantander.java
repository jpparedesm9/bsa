package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.OrchestrationClientValidationResponse;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;
import com.cobiscorp.ecobis.cobiscloudparty.bsl.dto.CustomerCoreInfo;

/**
 * Se toma de la clase QueryBureau de mantenimiento para acolparla
 */
public class QuerySantander extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QuerySantander.class);

	public QuerySantander(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerCoreInfo querySantander(Integer idCustomer, IExecuteCommandEventArgs iExecuteCommandEventArgs) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeCommand in QuerySantander - Pantalla Regularizedispersionsrejected");
		}
		
		try {
			if (idCustomer != null) {
				ValidationProspectServiceRequest validationProspectServiceRequest = new ValidationProspectServiceRequest();
				ValidationProspectRequest validationProspectRequest = new ValidationProspectRequest();
				validationProspectRequest.setCustomerId(idCustomer);
				validationProspectServiceRequest.setInValidationProspectRequest(validationProspectRequest);
				com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER, "OrchestrationClientValidationServiceSERVImpl.validateSantanderWithoutValidation",
						new Object[] { validationProspectServiceRequest });
				
				if (serviceResponse.isResult()) {
					OrchestrationClientValidationResponse orchestrationClientValidationResponse = (OrchestrationClientValidationResponse) serviceResponse.getData();
					CustomerCoreInfo santanderExecutionResponse = orchestrationClientValidationResponse.getCustomerCoreInfo();
					LOGGER.logDebug("QuerySantander - querySantander - santanderExecutionResponse" + santanderExecutionResponse);

					if (santanderExecutionResponse != null) {
						if (santanderExecutionResponse.getCustomerStdCode() == null || santanderExecutionResponse.getCustomerAccountId() == null) {
							LOGGER.logDebug("No tiene cuenta en Santander");
							iExecuteCommandEventArgs.getMessageManager().showErrorMsg("No tiene cuenta en Santander");
						}
						return santanderExecutionResponse;
					} else {
						iExecuteCommandEventArgs.setSuccess(false);
						LOGGER.logDebug("Error al consultar datos de Santander");
						iExecuteCommandEventArgs.getMessageManager().showErrorMsg("Error al consultar datos de Santander");
					}
				}
				
			} else {
				iExecuteCommandEventArgs.setSuccess(false);
				iExecuteCommandEventArgs.getMessageManager().showErrorMsg("CLIENTE NO EXISTE");
			}
		} catch (BusinessException be) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("BusinessException: ", be);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(be.getMessage());
		} catch (Exception e) {
			iExecuteCommandEventArgs.setSuccess(false);
			LOGGER.logError("Exception: ", e);
			System.out.println(e);
			iExecuteCommandEventArgs.getMessageManager().showErrorMsg(e.getMessage());
		}
		return null;
	}
}
