package com.cobiscorp.cobis.assts.customevents.events;

import java.util.List;

import cobiscorp.ecobis.assets.cloud.dto.LoanStatusChangeRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class StatusChangeHandler extends BaseEvent implements IExecuteCommand {

	private static final ILogger logger = LogFactory
			.getLogger(StatusChangeHandler.class);

	public StatusChangeHandler(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);

	}

	@Override
	public void executeCommand(DynamicRequest arg0,
			IExecuteCommandEventArgs arg1) {
	
		applyLoanStatusChange(arg0.getEntity(Loan.ENTITY_NAME), arg1);
	}

	public ServiceResponse applyLoanStatusChange(DataEntity loan,
			IExecuteCommandEventArgs args) {
		ServiceRequestTO request = new ServiceRequestTO();

		LoanStatusChangeRequest loanStatusChangeRequest = new LoanStatusChangeRequest();
		loanStatusChangeRequest.setLoanBankID(loan.get(Loan.LOANBANKID));
		loanStatusChangeRequest.setFinalStatus(loan.get(Loan.NEWSTATUS));

		request.addValue("inLoanStatusChangeRequest", loanStatusChangeRequest);
		ServiceResponse response = this.execute(getServiceIntegration(), logger,
				"Loan.LoanTransaction.LoanStatusChange", request);

		handleResponse(args, response);
		return response;
	}

	public void handleResponse(IExecuteCommandEventArgs args,
			ServiceResponse response) {
		if (response != null) {
			if (response.isResult()) {
				args.setSuccess(true);
				args.getMessageManager().showSuccessMsg(
						"La transacción se realizo exitosamente");
			} else {
				args.setSuccess(false);
				if (response.getMessages() != null) {
					args.getMessageManager().showErrorMsg(
							getSpsMessages(response.getMessages()));

					if (logger.isDebugEnabled()) {
						logger.logDebug(" ERROR EN EJECUCION: ");
					}
				}
			}
		}
	}

	public String getSpsMessages(List<Message> messages) {
		if (messages != null) {
			String messagesString = new String();
			for (Message message : messages) {
				messagesString = messagesString + " " + message.getMessage();
			}
			if (logger.isDebugEnabled()) {
				logger.logDebug(" MENSAJES: " + messagesString);
			}
			return messagesString;
		}
		return null;
	}

}
