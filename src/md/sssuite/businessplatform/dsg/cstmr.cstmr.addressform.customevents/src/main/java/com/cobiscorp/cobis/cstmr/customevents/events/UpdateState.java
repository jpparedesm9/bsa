package com.cobiscorp.cobis.cstmr.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;

public class UpdateState extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(UpdateState.class);

	public UpdateState(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			LOGGER.logDebug("****Inicia UpdateState*****");
			DataEntity requestEntity = entities.getEntity(PhysicalAddress.ENTITY_NAME);
			int enteId = requestEntity.get(PhysicalAddress.PERSONSECUENTIAL);
			LOGGER.logDebug("****enteId*****" + enteId);

			CustomerRequest customerRequest = new CustomerRequest();
			customerRequest.setOperation('U');
			customerRequest.setType('D');
			customerRequest.setCustomerId(enteId);
			customerRequest.setState("S");

			AddressManager addressManager = new AddressManager(getServiceIntegration());
			addressManager.updateState(customerRequest, args);

			LOGGER.logDebug("****Finaliza UpdateState*****");
		} catch (Exception e) {
			ExceptionUtils.showError("Error al actualizar estados", e, args, LOGGER);
		}
	}

}
