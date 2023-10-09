package com.cobiscorp.cobis.busin.customevents.form;

import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectRequest;
import com.cobiscorp.ecobis.cobiscloudorchestration.bsl.dto.ValidationProspectServiceRequest;

public class QuerRule extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(QuerRule.class);
	private static final String RETURN = "com.cobiscorp.cobis.cts.service.response.return";

	public QuerRule(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	public void executeQuerySantanderForClient(Integer customerClient) throws BusinessException {
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start executeQuerySantanderForClient");
		}
		ValidationProspectServiceRequest buroClientRequest = new ValidationProspectServiceRequest();

		ValidationProspectRequest clienteRequest = new ValidationProspectRequest();
		clienteRequest.setCustomerId(customerClient);

		buroClientRequest.setInValidationProspectRequest(clienteRequest);

		com.cobiscorp.cobis.web.services.commons.model.ServiceResponse serviceResponse = this.execute(LOGGER,
				"OrchestrationClientValidationServiceSERVImpl.getMatrixRulesInfoForClient", new Object[] { buroClientRequest });
		LOGGER.logDebug("Services response SantanderForClient" + serviceResponse.getData());
		ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
		if (serviceResponseTO == null) {
			throw new BusinessException(0, "Error al ejecutar la Matriz de Riesgo");
		} else {
			String returnValue = serviceResponseTO.getData().get(RETURN) == null ? null : String.valueOf(serviceResponseTO.getData().get(RETURN));
			LOGGER.logDebug("El returnValue es: " + returnValue);
			if (!"0".equals(returnValue)) {
				throw new BusinessException(0, "Error al ejecutar la Matriz de Riesgo");
			}
		}
		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Ejecuto executeQuerySantanderForClient");
		}

	}

}
