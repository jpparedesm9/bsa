package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Block;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class LCRExecuteCommand extends BaseEvent implements IExecuteCommand{

	private static final ILogger logger = LogFactory
			.getLogger(LCRExecuteCommand.class);
	
	public LCRExecuteCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("LCRExecuteCommand executeCommand>>>");
		}
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		DataEntity block = entities.getEntity(Block.ENTITY_NAME);
		
		
		String loanBankId = loan.get(Loan.LOANBANKID);
		Integer customerId = loan.get(Loan.CLIENTID);
		String currentBlocked = block.get(Block.BLOCKED);
		String blocked;
		
		BlockCreditService blockCreditService = new BlockCreditService(this.getServiceIntegration());
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("currentBlocked>>>"+currentBlocked);
		}
		
		if ("S".equals(currentBlocked)) {
			blocked = "N";
		}else {
			blocked = "S";
		}
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("blocked>>>"+blocked);
		}
		
		ServiceResponse serviceResponse = blockCreditService.executeBlockService(loanBankId, customerId, blocked, Parameter.OPERATIONI);
		
		GeneralFunction.handleResponse(args, serviceResponse, null);

		blockCreditService.getBlocks(entities,args);
		
	}

}
