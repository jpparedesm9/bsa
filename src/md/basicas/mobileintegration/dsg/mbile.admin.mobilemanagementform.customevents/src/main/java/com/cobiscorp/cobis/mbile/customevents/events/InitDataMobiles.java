package com.cobiscorp.cobis.mbile.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.commons.events.MobilesByAll;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataMobiles extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataMobiles.class);

	public InitDataMobiles(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {

		try {
			MobilesByAll businessByCustomer = new MobilesByAll(getServiceIntegration());
			businessByCustomer.searchMobiles(entities, args);

		} catch (Exception e) {
			 ExceptionUtils.showError(ExceptionMessage.MovileIntegration.INIT_DATA_MOVILES, e, args, LOGGER);
		}

	}
}