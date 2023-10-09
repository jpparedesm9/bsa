package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class RefreshGridChangeEvent extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(RefreshGridChangeEvent.class);
	
	public RefreshGridChangeEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs changedEventArgs) {
		try{
		LoadEconomicActivities loadEconomicActivitiesList = new LoadEconomicActivities(getServiceIntegration());
		loadEconomicActivitiesList.loadEconomicActivities(entities);
		}
		catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPDATE_ECONOMIC_ACTIVITY, e, changedEventArgs, LOGGER);
		}
	}

}
