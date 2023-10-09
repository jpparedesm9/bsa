package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.SolidarityPaymentManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchSolidarityAll extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchSolidarityAll.class);

	public SearchSolidarityAll(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			
			LOGGER.logDebug("Start executeCommand in SearchSolidarityAll");
			SolidarityPaymentManager searchReferences = new SolidarityPaymentManager(getServiceIntegration());
			
			searchReferences.readSolidarityByOperation(entities, args);
			searchReferences.searchSolidarityDetailByOperation(entities, args);
			
		} catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Pago Solidario" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Recuperar Pago Solidario ");
		} finally {
			LOGGER.logDebug("Finish executeCommand in SearchSolidarityAll");			
		}
	}

}
