package com.cobiscorp.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class DocumentsPrintingIni extends BaseEvent implements IInitDataEvent{

	private static final ILogger logger = LogFactory
			.getLogger(DocumentsPrintingIni.class);

	public DocumentsPrintingIni(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs arg1) {
		if (logger.isDebugEnabled()) {
			logger.logInfo("-->DocumentsPrintingIni >>> executeDataEvent");
		}		
		
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		DataEntity loanSession = (DataEntity) AssetsSessionManager
				.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
			
		if(loanSession!=null){
			entities.setEntity(Loan.ENTITY_NAME, loanSession);	
		}
		
		if (getServiceIntegration() == null && logger.isDebugEnabled()) {
			logger.logInfo("-->LoadQueries ServiceIntegration es nulo ");
		}
	}

	
}
