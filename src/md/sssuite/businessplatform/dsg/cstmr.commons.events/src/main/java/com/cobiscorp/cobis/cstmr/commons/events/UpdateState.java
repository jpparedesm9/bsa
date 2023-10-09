package com.cobiscorp.cobis.cstmr.commons.events;

import com.cobiscorp.cobis.busin.model.DebtorGeneral;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.CustomerTmp;
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
			DataEntity customerTmp = entities.getEntity(CustomerTmp.ENTITY_NAME);
			DataEntity debGenral = entities.getEntity(DebtorGeneral.ENTITY_NAME);
			int customerId = 0;
			if (customerTmp != null) {
				customerId = customerTmp.get(CustomerTmp.CODE);
			} else if (debGenral != null) {
				customerId = debGenral.get(DebtorGeneral.CUSTOMERCODE);
			}
			if (customerId == 0) {
				throw new IllegalStateException("El customerId No puede ser 0");
			}

			LOGGER.logDebug("customerId ---" + customerId);

			// datos de entrada comunes
			CustomerRequest customerRequest = new CustomerRequest();
			AddressManager addressManager = new AddressManager(getServiceIntegration());

			customerRequest.setOperation('U');
			customerRequest.setCustomerId(customerId);
			customerRequest.setState("S");

			LOGGER.logDebug("----UpdateState Direccion----");
			customerRequest.setType('D');
			addressManager.updateState(customerRequest, args);
			LOGGER.logDebug("----UpdateState Direccion----");

			LOGGER.logDebug("****UpdateState Mail*****");
			customerRequest.setType('M');
			addressManager.updateState(customerRequest, args);
			LOGGER.logDebug("****UpdateState Mail*****");

			LOGGER.logDebug("****Finaliza UpdateState*****");
		} catch (Exception e) {
			ExceptionUtils.showError("Error al actualizar estados", e, args, LOGGER);
		}
	}

}
