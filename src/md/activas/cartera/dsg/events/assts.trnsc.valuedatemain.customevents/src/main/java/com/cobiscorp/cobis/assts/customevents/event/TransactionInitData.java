package com.cobiscorp.cobis.assts.customevents.event;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.sessions.AssetsSessionManager;
import com.cobiscorp.cobis.assts.customevents.baseevents.TransactionBaseEvent;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class TransactionInitData extends BaseEvent implements IInitDataEvent {

	private static final ILogger logger = LogFactory
			.getLogger(TransactionInitData.class);

	public TransactionInitData(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities, IDataEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeDataEvent TransactionInitData");
		}
		TransactionBaseEvent transactionBaseEvents = new TransactionBaseEvent(
				getServiceIntegration());

		try {
			DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);

			DataEntity loanSession = (DataEntity) AssetsSessionManager
					.getLoan(loanInstance.get(LoanInstancia.IDINSTANCIA));
				
			if(loanSession!=null){
				entities.setEntity(Loan.ENTITY_NAME, loanSession);	
			} 
			
			char opcion = 'F';
			if (loanInstance.get(LoanInstancia.TIPO) != null) {
				opcion = loanInstance.get(LoanInstancia.TIPO).charAt(0);
			}
			
			DataEntityList transacciones = transactionBaseEvents
					.loadTransactionList(entities, opcion);
			if (!(transacciones.isEmpty())) {
				args.setSuccess(true);
			}
		} catch (Exception ex) {
			logger.logDebug("===>Excepcion: " + ex);
		}
		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza executeDataEvent TransactionInitData");
		}
	}
}
