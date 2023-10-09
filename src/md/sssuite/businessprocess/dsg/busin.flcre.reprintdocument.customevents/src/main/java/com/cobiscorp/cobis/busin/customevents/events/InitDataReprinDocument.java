package com.cobiscorp.cobis.busin.customevents.events;


import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.systemconfiguration.dto.ParameterResponse;

import com.cobiscorp.cobis.busin.flcre.commons.dto.BehaviorOption;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.busin.flcre.commons.services.CatalogManagement;
import com.cobiscorp.cobis.busin.model.Context;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class InitDataReprinDocument extends BaseEvent implements IInitDataEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(InitDataReprinDocument.class);

	public InitDataReprinDocument(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {
		// TODO Auto-generated method stub
		try{
			ParameterResponse parameterResponse = new ParameterResponse();
			DataEntity entityContext = arg0.getEntity(Context.ENTITY_NAME);
			CatalogManagement catalogManagement = new CatalogManagement(this.getServiceIntegration());
			// consulto parametro de gestion de reclamos y lo seteo en la entidad
			// Context
			parameterResponse = catalogManagement.getParameter(4, "GESTRE", "CRE", arg1, new BehaviorOption(true));
			entityContext = arg0.getEntity(Context.ENTITY_NAME);
			entityContext.set(Context.TYPE, parameterResponse.getParameterValue());
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessProcess.REPRINT_INITDATA_REPRINT, e, arg1, LOGGER);
		}

	}

}
