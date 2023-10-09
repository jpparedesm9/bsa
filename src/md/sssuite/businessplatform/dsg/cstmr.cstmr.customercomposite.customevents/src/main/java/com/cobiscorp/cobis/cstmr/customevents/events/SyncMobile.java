package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.CustomerSyncRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.SyncManager;

public class SyncMobile extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SyncMobile.class);

	public SyncMobile(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try {
			LOGGER.logDebug("executeCommand SyncMobile Customer");
			
			args.setSuccess(true);
			
			DataEntity requestEntity = entities.getEntity(NaturalPerson.ENTITY_NAME);
			int customerId = requestEntity.get(NaturalPerson.PERSONSECUENTIAL);

			CustomerSyncRequest businessRequest = new CustomerSyncRequest();

			businessRequest.setCustomerId(customerId);
			
			SyncManager syncManager = new SyncManager(getServiceIntegration());
			syncManager.syncCustomer(businessRequest, args);
			
		}  catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.READ_SYNC_MOBILE, e, args, LOGGER);
		}

	}

}
