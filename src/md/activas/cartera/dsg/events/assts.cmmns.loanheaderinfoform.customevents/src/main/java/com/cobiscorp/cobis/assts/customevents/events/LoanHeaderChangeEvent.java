package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.events.GeneralFunction;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;

public class LoanHeaderChangeEvent implements IChangedEvent {
	private static final ILogger logger = LogFactory
			.getLogger(LoanHeaderChangeEvent.class);
	private ICTSServiceIntegration serviceIntegration;

	public LoanHeaderChangeEvent(ICTSServiceIntegration serviceIntegration) {
		this.serviceIntegration = serviceIntegration;
		if (logger.isDebugEnabled()) {
			logger.logDebug("SE INSTANCIA EVENTO CHANGE");
		}
	}

	@Override
	public void changed(DynamicRequest arg0, IChangedEventArgs arg1) {
		ServiceResponse response;
		LoanHeaderController loanHeaderController = new LoanHeaderController(
				this.serviceIntegration);
		response = loanHeaderController.loadLoanHeader(arg0
				.getEntity(Loan.ENTITY_NAME));
		GeneralFunction.handleResponse(arg1, response, null);
	}
}
