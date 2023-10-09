package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.SolidarityPaymentManager;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class SearchSolidarityDetail extends BaseEvent implements IChangedEvent {

	private static final ILogger LOGGER = LogFactory
			.getLogger(SearchSolidarityDetail.class);

	public SearchSolidarityDetail(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		try {

			LOGGER.logDebug("Start changed in SearchSolidarityDetail");
			SolidarityPaymentManager searchReferences = new SolidarityPaymentManager(
					getServiceIntegration());

    	searchReferences.searchSolidarityDetailByOperation(entities, args);

		} catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Pago Solidario", e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg(
					"Error al Recuperar Pago Solidario ");
		} finally {
			LOGGER.logDebug("Finish changed in SearchSolidarityDetail");
		}

	}

}
