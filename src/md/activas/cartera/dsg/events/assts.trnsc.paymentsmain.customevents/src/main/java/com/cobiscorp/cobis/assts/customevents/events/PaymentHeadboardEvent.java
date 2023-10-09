package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentHeadboard;
import cobiscorp.ecobis.assets.cloud.dto.LoanPaymentRequest;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.Loan;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class PaymentHeadboardEvent extends BaseEvent {

	private static final ILogger logger = LogFactory
			.getLogger(PaymentHeadboardEvent.class);

	public PaymentHeadboardEvent(
			ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	
	public LoanPaymentHeadboard paymentHeadboar(DynamicRequest entities) {

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		DataEntity loan = entities.getEntity(Loan.ENTITY_NAME);		
		LoanPaymentRequest loanPaymentRequest = new LoanPaymentRequest();
		
		loanPaymentRequest.setDateFormat(103);
		loanPaymentRequest.setBank(loan.get(Loan.LOANBANKID));

		serviceRequestTO.addValue("inLoanPaymentRequest", loanPaymentRequest);
		LoanPaymentHeadboard loanPaymentHead = null;
		ServiceResponse serviceResponse = this.execute(logger,
				Parameter.PROCESS_LOAN_PAYMENT, serviceRequestTO);

		if (serviceResponse.isResult()) {
			ServiceResponseTO serviceResponseTO = (ServiceResponseTO) serviceResponse.getData();
			if (serviceResponseTO.isSuccess()) {
				loanPaymentHead = (LoanPaymentHeadboard) serviceResponseTO
						.getValue("returnLoanPaymentHeadboard");
			}
		}		
			
		return loanPaymentHead;
	}

}
