package com.cobiscorp.cobis.assts.customevents.event;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.customevents.baseevents.TransactionBaseEvent;
import com.cobiscorp.cobis.assts.customevents.baseevents.ValueDataBaseEvent;
import com.cobiscorp.cobis.assts.model.LoanInstancia;
import com.cobiscorp.cobis.assts.model.ValueDateFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class ValueDateTranManager extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory
			.getLogger(ValueDateTranManager.class);

	public ValueDateTranManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeCommand(DynamicRequest entities,
			IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("Inicia executeCommand ValueDateTranManager");
		}
		DataEntity loanInstance = entities.getEntity(LoanInstancia.ENTITY_NAME);
		
		char opcion = 'F';
		if (loanInstance.get(LoanInstancia.TIPO) != null) {
			opcion = loanInstance.get(LoanInstancia.TIPO).charAt(0);
		}
		
		ValueDataBaseEvent valueDataBaseEvent = new ValueDataBaseEvent(
				getServiceIntegration());
		
		if (opcion == 'G') {
			//Reverso de pago grupal
			valueDataBaseEvent.generateReverseValueDateOrder(entities, args);
		} else {
			valueDataBaseEvent.applyReverseValueDate(entities, args);
		}
		
		if (args.isSuccess()) {
			TransactionBaseEvent transactionBaseEvents = new TransactionBaseEvent(
					getServiceIntegration());
			
			transactionBaseEvents.loadTransactionList(entities, opcion);
			DataEntity valueDateFilter = entities
					.getEntity(ValueDateFilter.ENTITY_NAME);
			valueDateFilter.set(ValueDateFilter.OBSERVATION, "");
		}

		if (logger.isDebugEnabled()) {
			logger.logDebug("Finaliza executeCommand ValueDateTranManager");
		}
	}
}
