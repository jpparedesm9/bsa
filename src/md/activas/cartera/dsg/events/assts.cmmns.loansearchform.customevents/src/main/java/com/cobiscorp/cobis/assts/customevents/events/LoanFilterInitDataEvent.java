package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.sessions.LoanInstanceSession;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.LoanSearchFilter;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;

public class LoanFilterInitDataEvent implements IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoanFilterInitDataEvent.class);

	public LoanFilterInitDataEvent(ICTSServiceIntegration serviceIntegration) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("SE INSTANCIA EVENTO");
		}
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		DataEntity item = new DataEntity();
		
		entities.setEntity(LoanSearchFilter.ENTITY_NAME, item);
		if (logger.isDebugEnabled()) {
			logger.logDebug("SE INSTANCIA EVENTO LoanSearchFilter" +entities.getData());
		}
		DataEntity loanInstancia = entities
				.getEntity(LoanInstancia.ENTITY_NAME);

		if (logger.isDebugEnabled()) {
			logger.logDebug("SE INSTANCIA EVENTO loanInstancia" +loanInstancia.getData());
		}
		
		loanInstancia.set(LoanInstancia.IDINSTANCIA, LoanInstanceSession
				.obtenerCodigoAleatorio(args.getParameters().getTabGuid()));
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("DATOS loanInstancia>>>>>>>" + loanInstancia.getData());
		}

	}

}
