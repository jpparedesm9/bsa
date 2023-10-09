package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
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

public class LCRCancelExecuteCommand extends BaseEvent implements IExecuteCommand{

	private static final ILogger logger = LogFactory.getLogger();
	
	public LCRCancelExecuteCommand(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("LCRCancelExecuteCommand executeCommand>>>");
		}
		
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
		
		String loanBankId = loan.get(Loan.LOANBANKID);
	
		LCRCancelCreditService cancelCreditService = new LCRCancelCreditService(this.getServiceIntegration());
		
		ServiceResponse serviceResponse;
		serviceResponse = cancelCreditService.executeCancelService(loanBankId);
		
		if(serviceResponse != null && serviceResponse.isResult()) {
			args.setSuccess(true);
			args.getMessageManager().showSuccessMsg("La cancelación se realizo exitosamente");
		}else {
			args.getMessageManager().showErrorMsg(GeneralFunction.getSpsMessages(serviceResponse.getMessages()));
		}
		
	}
	
}
