package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class SavePayment extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory.getLogger(SavePayment.class);

	public SavePayment(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs arg1) {

		// Id de Servicio
		String serviceId = "Loan.GroupPaymentManagement.InsertGroupPayment";

		ServiceRequestTO serviceRequest = new ServiceRequestTO();

		// mapeo atributos de Entrada (tipo de dato - nombre)
		DataEntity groupPaymenInfo = entities.getEntity(com.cobiscorp.cobis.assts.model.GroupPaymenInfo.ENTITY_NAME);
		DataEntity groupPaymentFilter = entities
				.getEntity(com.cobiscorp.cobis.assts.model.GroupPaymentFilter.ENTITY_NAME);

		cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest requestInGroupPaymentRequest = new cobiscorp.ecobis.assets.cloud.dto.GroupPaymentRequest();

		requestInGroupPaymentRequest.setAmount(
				groupPaymenInfo.get(com.cobiscorp.cobis.assts.model.GroupPaymenInfo.VALUEAMOUNTUSEGUARANTEE));
		requestInGroupPaymentRequest.setGroup(
				Integer.valueOf(groupPaymentFilter.get(com.cobiscorp.cobis.assts.model.GroupPaymentFilter.GROUP)));

		// Invocación de servicio
		serviceRequest.addValue("inGroupPaymentRequest", requestInGroupPaymentRequest);

		// Ejecución de servicio
		ServiceResponse response = this.execute(logger, serviceId, serviceRequest);

		// Mapeo de respuesta
		if (response.isResult()) {
			ServiceResponseTO resultado = (ServiceResponseTO) response.getData();
			if (resultado.isSuccess()) {
				arg1.setSuccess(true);
				GeneralFunction.handleResponse(arg1, response, "ASSTS.LBL_ASSTS_ELPAGOSIL_41298");
			} else {
				arg1.setSuccess(false);
				GeneralFunction.handleResponse(arg1, response, null);
				if (logger.isDebugEnabled())
					logger.logDebug(" ERROR EN EJECUCION: ");
			}
		} else {
			arg1.setSuccess(false);
			GeneralFunction.handleResponse(arg1, response, null);
		}

	}

}
