package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchAddresses extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchAddresses.class);

	public SearchAddresses(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			LOGGER.logDebug("Start executeCommand in SearchAddresses");
			SearchAddressesByCustomer searchAddresses = new SearchAddressesByCustomer(getServiceIntegration());
			searchAddresses.searchAddressesByCustomer(entities, args);
		} catch (BusinessException e) {
			LOGGER.logDebug("Error al Recuperar Direcciones" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Recuperar Direcciones "+e.getMessage());
		} catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Direcciones" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Recuperar Direcciones");
		} finally {
			LOGGER.logDebug("Finish executeCommand in SearchAddresses");			
		}
	}

}
