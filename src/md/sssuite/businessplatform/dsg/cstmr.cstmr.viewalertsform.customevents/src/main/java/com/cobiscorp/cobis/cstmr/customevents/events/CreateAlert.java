package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AlertRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.GeneralFunction;
import com.cobiscorp.cobis.cstmr.model.UnusualOperations;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AlertManager;

public class CreateAlert extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(CreateAlert.class);

	public CreateAlert(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		args.setSuccess(true);
		try {

			LOGGER.logDebug("Starte Create UnusualOperations");

			DataEntity requestEntity = entities.getEntity(UnusualOperations.ENTITY_NAME);

			AlertRequest alertRequest = new AlertRequest();

			alertRequest.setTypeOperation(requestEntity.get(UnusualOperations.TYPEOPERATION));
			//alertRequest.setHighDate(requestEntity.get(UnusualOperations.HIGHDATE));
			if(requestEntity.get(UnusualOperations.HIGHDATE) != null){
				alertRequest.setHighDate(GeneralFunction.convertDateToCalendar(requestEntity.get(UnusualOperations.HIGHDATE)));
			}
			//alertRequest.setReportDate(requestEntity.get(UnusualOperations.REPORTDATE));
			if(requestEntity.get(UnusualOperations.REPORTDATE) != null){
				alertRequest.setReportDate(GeneralFunction.convertDateToCalendar(requestEntity.get(UnusualOperations.REPORTDATE)));
			}
			alertRequest.setCustomerName(requestEntity.get(UnusualOperations.CUSTOMERNAME));
			alertRequest.setCustomerSecondName(requestEntity.get(UnusualOperations.CUSTOMERSECONDNAME));
			alertRequest.setCustomerSurname(requestEntity.get(UnusualOperations.CUSTOMERSURNAME));
			alertRequest.setCustomerSecondSurname(requestEntity.get(UnusualOperations.CUSTOMERSECONDSURNAME));
			alertRequest.setCommentary(requestEntity.get(UnusualOperations.COMMENTARY));

			AlertManager alertManager = new AlertManager(getServiceIntegration());

			alertManager.createAlert(alertRequest, args);
			
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CREATE_ALERT, e, args, LOGGER);
		}

	}

}
