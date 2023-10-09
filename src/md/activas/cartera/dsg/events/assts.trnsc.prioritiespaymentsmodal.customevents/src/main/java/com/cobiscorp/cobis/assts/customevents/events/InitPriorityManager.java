package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assts.model.Priorities;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IInitDataEvent;
import com.cobiscorp.designer.api.customization.arguments.IDataEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class InitPriorityManager extends BaseEvent implements IInitDataEvent {
	private static final ILogger logger = LogFactory
			.getLogger(InitPriorityManager.class);

	public InitPriorityManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void executeDataEvent(DynamicRequest entities,
			IDataEventArgs dataEventArgs) {
		
		priorityQuery(entities, dataEventArgs);

	}

	public void priorityQuery(DynamicRequest entities,
			IDataEventArgs dataEventArgs) {
		if (logger.isDebugEnabled()) {
			logger.logDebug("priorityQuery - InitPriorityManager");
		}
		String loanBankId = String.valueOf(dataEventArgs.getParameters().getCustomParameters().get("bankNum"));
		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();
		loanPaymentRequest.setPaymentType("A");
		loanPaymentRequest.setPaymentTypeCan("A");
		loanPaymentRequest.setCancel("N");
		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loanBankId);

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);

		ServiceResponse serviceResponse = this.execute(logger,
				"Loan.ProductListCredit.QueryLoanPayment", serviceRequestTO);
		loanResponse(entities, serviceResponse);
	}

	// LoanPaymentPriorities
	public void loanResponse(DynamicRequest entities,
			ServiceResponse serviceResponse) {
		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse
					.getData();
			if (serviceResponseTO.isSuccess()) {
				// GRID
				DataEntityList dataEntityList = entities
						.getEntityList(Priorities.ENTITY_NAME);
				logger.logDebug("JBA >>>>>>>>>>>>"+ dataEntityList.getDataList());
			}
		}
	}
}
