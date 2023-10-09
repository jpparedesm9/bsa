package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;

public class LoanHeaderInitDataEvent implements IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoanHeaderInitDataEvent.class);
	private ICTSServiceIntegration serviceIntegration;

	public LoanHeaderInitDataEvent(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		if (logger.isDebugEnabled()) {
			logger.logDebug("SE INSTANCIA EVENTO");
		}
	}

	@Override
	public void executeDataEvent(DynamicRequest arg0, IDataEventArgs arg1) {
		ServiceResponse response;
		LoanHeaderController loanHeaderController = new LoanHeaderController(
				this.serviceIntegration);
		response = loanHeaderController.loadLoanHeader(arg0
				.getEntity(Loan.ENTITY_NAME));
		GeneralFunction.handleResponse(arg1, response, null);
	}
}
