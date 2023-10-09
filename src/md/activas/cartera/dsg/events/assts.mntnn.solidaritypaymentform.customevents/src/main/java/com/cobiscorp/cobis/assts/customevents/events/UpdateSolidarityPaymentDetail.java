package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.SolidarityPaymentManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class UpdateSolidarityPaymentDetail extends BaseEvent implements IExecuteCommand{
	
	private static final ILogger LOGGER = LogFactory
			.getLogger(UpdateSolidarityPaymentDetail.class);

	public UpdateSolidarityPaymentDetail(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try {
			
			LOGGER.logDebug("Starte Update Solidarity Payment Detail");
			
			SolidarityPaymentManager searchReferences = new SolidarityPaymentManager(getServiceIntegration());
			searchReferences.updateSolidarityDetail(entities, args);
			
			args.setSuccess(true);
		} catch (Exception e) {
			args.setSuccess(false);
			LOGGER.logError("Error en createReferences",e);
		}
		
	}

}
