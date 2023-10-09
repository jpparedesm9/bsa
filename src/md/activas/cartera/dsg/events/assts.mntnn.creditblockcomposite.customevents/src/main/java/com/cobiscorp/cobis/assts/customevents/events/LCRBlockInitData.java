package com.cobiscorp.cobis.assts.customevents.events;

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

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LCRBlockInitData extends BaseEvent implements IInitDataEvent{

	public LCRBlockInitData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		}
	
	
	private static final ILogger logger = LogFactory
			.getLogger(LCRBlockInitData.class);
	
	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Ingresa a LCRBlockInitData>>>");
		}
		try {
			DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
			
			if (logger.isDebugEnabled()) {
				logger.logDebug("LoanInstancia.IDINSTANCIA>>>"+loanInstance.get(LoanInstancia.IDINSTANCIA));
			}

			DataEntity loanSession = (DataEntity) AssetsSessionManager
					.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));

			if (loanSession != null) {
				entities.setEntity(Loan.ENTITY_NAME, loanSession);
			}
			
			//Consulta de Bloqueos
			
	        BlockCreditService blockCreditService = new BlockCreditService(this.getServiceIntegration());
			blockCreditService.getBlocks(entities,args);
			
		} catch (Exception e) {
			logger.logError("Error en BlockCreditService: ",  e);
		}
		
	}



}
