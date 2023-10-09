package com.cobiscorp.cobis.assts.massivepayments.customevents.events;

import com.cobiscorp.cobis.assts.model.MassivePaymentRecord;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class CleanData extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(CleanData.class);
	
	public CleanData(ICTSServiceIntegration serviceIntegration){
		super(serviceIntegration);
	}
	
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		DataEntityList paymentsList = new DataEntityList();
		LOGGER.logDebug("Cleaning List");
		entities.setEntityList(MassivePaymentRecord.ENTITY_NAME, paymentsList);
	}

}
