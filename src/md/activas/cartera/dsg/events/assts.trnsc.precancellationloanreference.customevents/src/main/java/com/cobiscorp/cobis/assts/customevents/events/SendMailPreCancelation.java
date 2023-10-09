package com.cobiscorp.cobis.assts.customevents.events;

import java.math.BigDecimal;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.assts.model.PreCancellation;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteCommand;
import com.cobiscorp.designer.api.customization.arguments.IExecuteCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;

public class SendMailPreCancelation extends BaseEvent implements IExecuteCommand {

	private static final ILogger LOGGER = LogFactory.getLogger(SendMailPreCancelation.class);

	public SendMailPreCancelation(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void executeCommand(DynamicRequest entities, IExecuteCommandEventArgs args) {
		// TODO Auto-generated method stub
		try {
			args.setSuccess(true);
			LOGGER.logDebug("Ingresa a executeCommand de SendMailPreCancelation");

			ServiceRequestTO request = new ServiceRequestTO();
			
			DataEntity precancellation = entities.getEntity(PreCancellation.ENTITY_NAME);
			LOGGER.logDebug("LOAN " + Loan.ENTITY_NAME); 
			DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);
			int customerId = loan.get(Loan.CLIENTID);
			BigDecimal monto = precancellation.get(PreCancellation.AMOUNTPRE);

			LoanRequest loanRequest = new LoanRequest();

			loanRequest.setClient(customerId);
			loanRequest.setAmountDs(monto);
			
			request.addValue("inLoanRequest", loanRequest);

			this.execute(getServiceIntegration(), LOGGER, Parameter.MAIL_PRECANCELLATION, request);

		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.Assets.MAIL_PRECANCELATION, e, args, LOGGER);
		}

	}
}
