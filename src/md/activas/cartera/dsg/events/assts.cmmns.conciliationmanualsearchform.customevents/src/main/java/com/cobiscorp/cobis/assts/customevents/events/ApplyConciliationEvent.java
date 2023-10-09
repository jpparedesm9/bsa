package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.ConciliationManualSearch;
import com.cobiscorp.cobis.assts.model.ConciliationManualSearchFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.assets.cloud.dto.ConciliationManualOperationRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class ApplyConciliationEvent extends BaseEvent implements IOnCloseModalEvent {

	private static final ILogger logger = LogFactory.getLogger(SearchConciliationEvent.class);

	private static final String CONSTANT_WITHOUT_ACTION = "AC";

	private static final String CONSTANT_SUCCESSFUL_CONCILIATION = "Conciliación Exitosa";

	public ApplyConciliationEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void onCloseModalEvent(DynamicRequest entities, ICloseModalEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Entry ApplyConciliationEvent - onCloseModalEvent");
		}

		try {
			ServiceRequestTO request = new ServiceRequestTO();

			DataEntity conciliationSearchFilter = entities.getEntity(ConciliationManualSearchFilter.ENTITY_NAME);

			DataEntityList list = entities.getEntityList(ConciliationManualSearch.ENTITY_NAME);

			ConciliationManualOperationRequest conciliationManualOperationRequest = new ConciliationManualOperationRequest();

			String observation = conciliationSearchFilter.get(ConciliationManualSearchFilter.OBSERVATION);
			String operation = conciliationSearchFilter.get(ConciliationManualSearchFilter.CONCILIATIONTYPE);

			conciliationManualOperationRequest.setObservation(observation);
			conciliationManualOperationRequest.setOperation(operation);

			if (CONSTANT_WITHOUT_ACTION.equals(operation)) {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" ACLARAR SIN ACCION: " + operation);
				}
				methodWithoutAction(entities, args, request, list, conciliationManualOperationRequest);
			} else {
				if (logger.isDebugEnabled()) {
					logger.logDebug(" OTRAS ACCIONES: " + operation);
				}
				methodOtherActions(entities, args, request, list, conciliationManualOperationRequest);
			}
		} catch (Exception error) {
			logger.logError("ERROR: AL APLICAR LA CONCILIACION MANUAL ", error);
		}

	}

	private void methodWithoutAction(DynamicRequest entities, ICloseModalEventArgs args, ServiceRequestTO request, DataEntityList list, ConciliationManualOperationRequest conciliationManualOperationRequest) {
		StringBuilder bld = new StringBuilder();
		for (DataEntity result : list) {
			if (result.get(ConciliationManualSearch.ISSELECTED)) {
				bld.append(result.get(ConciliationManualSearch.SEQUENTIALCODE).toString() + ";");
			}
		}
		String ids = bld.toString();
		conciliationManualOperationRequest.setRecordsCode(ids);

		request.addValue("inConciliationManualOperationRequest", conciliationManualOperationRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.ConciliationManagement.ApplyOperationManualConciliation", request);

		if (response != null) {
			if (response.isResult()) {
				args.setSuccess(true);
				args.getMessageManager().showSuccessMsg(CONSTANT_SUCCESSFUL_CONCILIATION);
			} else {
				args.setSuccess(false);
				if (response.getMessages() != null) {
					args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
				}
			}
		}
	}

	private void methodOtherActions(DynamicRequest entities, ICloseModalEventArgs args, ServiceRequestTO request, DataEntityList list, ConciliationManualOperationRequest conciliationManualOperationRequest) {
		for (DataEntity result : list) {
			if (result.get(ConciliationManualSearch.ISSELECTED)) {
				String recordsCode = result.get(ConciliationManualSearch.SEQUENTIALCODE).toString();
				conciliationManualOperationRequest.setRecordsCode(recordsCode);

				request.addValue("inConciliationManualOperationRequest", conciliationManualOperationRequest);
				ServiceResponse response = this.execute(getServiceIntegration(), logger, "Loan.ConciliationManagement.ApplyOperationManualConciliation", request);

				if (response != null && !response.isResult()) {
					args.setSuccess(false);
					if (response.getMessages() != null) {
						args.getMessageManager().showErrorMsg(getSpsMessages(response.getMessages()));
					}
					return;
				}
			}
		}

		args.setSuccess(true);
		args.getMessageManager().showSuccessMsg(CONSTANT_SUCCESSFUL_CONCILIATION);
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = Parameter.EMPTY_VALUE;
			for (Message message : messages) {
				messagesString = messagesString.concat(" ").concat(message.getMessage());
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}
}
