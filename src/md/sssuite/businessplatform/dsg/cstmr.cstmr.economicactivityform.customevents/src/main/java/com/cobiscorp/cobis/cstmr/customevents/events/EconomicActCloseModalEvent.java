package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IOnCloseModalEvent;
import com.cobiscorp.designer.api.customization.arguments.ICloseModalEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class EconomicActCloseModalEvent extends BaseEvent implements IOnCloseModalEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(EconomicActCloseModalEvent.class);
	
	public EconomicActCloseModalEvent(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void onCloseModalEvent(DynamicRequest arg0, ICloseModalEventArgs arg1) {
		try{
		LoadEconomicActivities loadEconomicActivitiesList = new LoadEconomicActivities(getServiceIntegration());
		loadEconomicActivitiesList.loadEconomicActivities(arg0);
		}
		catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.CLOSEMODAL_ECONOMIC_ACTIVITY, e, arg1, LOGGER);
		}
	}

}
