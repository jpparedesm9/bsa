package com.cobiscorp.cobis.mbile.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.commons.events.SyncDataByFilter;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchDataSync extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchDataSync.class);

	public SearchDataSync(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {

		try {
			SyncDataByFilter businessByCustomer = new SyncDataByFilter(getServiceIntegration());
			businessByCustomer.searchDataSync(entities, args);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.MovileIntegration.DELETE_MOVILE, e, args, LOGGER);
		}

	}
}