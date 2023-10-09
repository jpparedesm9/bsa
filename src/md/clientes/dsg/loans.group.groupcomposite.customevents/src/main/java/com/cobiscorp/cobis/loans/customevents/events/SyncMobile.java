package com.cobiscorp.cobis.loans.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.GroupSyncRequest;

import com.cobiscorp.cobis.busin.flcre.commons.services.SyncManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.model.Group;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

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
			LOGGER.logDebug("executeCommand SyncMobile Group");

			args.setSuccess(true);

			DataEntity requestEntity = entities.getEntity(Group.ENTITY_NAME);
			int groupId = requestEntity.get(Group.CODE);

			GroupSyncRequest groupSyncRequest = new GroupSyncRequest();

			groupSyncRequest.setGroupId(groupId);

			SyncManager syncManager = new SyncManager(getServiceIntegration());
			syncManager.syncGroup(groupSyncRequest, args);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Clients.SYNCRONIZATION_MOVIL_GROUP, e, args, LOGGER);
		}

	}

}
