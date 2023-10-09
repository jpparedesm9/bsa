package com.cobiscorp.cobis.mbile.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchMobiles extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchMobiles.class);

	public SearchMobiles(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		try {
			LOGGER.logDebug("Start executeCommand in SearchMobiles");
			MobilesByAll searchBusiness = new MobilesByAll(getServiceIntegration());
			searchBusiness.searchMobiles(entities, args);
		}  catch (Exception e) {
			 ExceptionUtils.showError(ExceptionMessage.MovileIntegration.SEARCH_ALL_DEVICES, e, args, LOGGER);
		} finally {
			LOGGER.logDebug("Finish executeCommand in SearchMobiles");			
		}
	}

}
