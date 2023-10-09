package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.commons.events.ReferencesByCustomer;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataReferences extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataReferences.class);

	public InitDataReferences(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {

		try {
			ReferencesByCustomer referencesByCustomer = new ReferencesByCustomer(getServiceIntegration());
			referencesByCustomer.searchReferencesByCustomer(entities, args);

		}  catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.INITDATA_REFERENCES, e, args, LOGGER);
		}

	}
}