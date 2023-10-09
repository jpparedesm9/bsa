package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.SolidarityPaymentManager;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class InitDataSolidarity extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataSolidarity.class);

	public InitDataSolidarity(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {

		try {

			SolidarityPaymentManager searchReferences = new SolidarityPaymentManager(getServiceIntegration());
			
			searchReferences.readSolidarityByOperation(entities, args);
			searchReferences.searchSolidarityDetailByOperation(entities, args);
		}  catch (Exception e) {
			LOGGER.logDebug("Error al Recuperar Pago Solidario" , e);
			args.setSuccess(false);
			args.getMessageManager().showErrorMsg("Error al Recuperar Pago Solidario ");
		} finally {
			LOGGER.logDebug("Finish executeCommand in InitDataSolidarity");			
		}

	}
}