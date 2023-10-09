package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import cobiscorp.ecobis.assets.cloud.dto.ConciliationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;


import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.ConciliationSearch;

public class ExecuteCommand_CM_TASSTSOD_AT8 extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(ExecuteCommand_CM_TASSTSOD_AT8.class);

	public ExecuteCommand_CM_TASSTSOD_AT8(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			ServiceRequestTO request = new ServiceRequestTO();
			ServiceResponse response = null;
			ConciliationRequest conciliationRequest = new ConciliationRequest();

			DataEntity conciliationSearch = entities.getEntity(ConciliationSearch.ENTITY_NAME);
			if (conciliationSearch.get(ConciliationSearch.REFERENCE) != null) {
				conciliationRequest.setReference(conciliationSearch.get(ConciliationSearch.REFERENCE));
				conciliationRequest.setObservation(conciliationSearch.get(ConciliationSearch.OBSERVATION));
				request.addValue("inConciliationRequest", conciliationRequest);
				response = this.execute(getServiceIntegration(), LOGGER, "Loan.ConciliationManagement.ManualConciliation", request);

				if (response != null) {
					if (response.isResult()) {
						args.setSuccess(true);
					} else {
						args.setSuccess(false);
						if (response.getMessages() != null) {
							args.getMessageManager().showErrorMsg(GeneralFunction.getSpsMessages(response.getMessages()));
						}
					}
				} else {
					args.setSuccess(false);

				}
			}
		} catch (Exception ex) {
			LOGGER.logError("Error in ExecuteCommand_CM_TASSTSOD_AT8: " + ex);
		}
	}
}
