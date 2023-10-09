package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.AddressByHome;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SearchAddressHome extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(SearchAddressHome.class);

	public SearchAddressHome(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try {
			LOGGER.logDebug("Start executeCommand in SearchBusiness");
			AddressByHome searchBusiness = new AddressByHome(getServiceIntegration());
			searchBusiness.searchAdressByHome(entities, args);
		}catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.SEARCH_ADDRESS, e, args, LOGGER);
		}
	}

}
