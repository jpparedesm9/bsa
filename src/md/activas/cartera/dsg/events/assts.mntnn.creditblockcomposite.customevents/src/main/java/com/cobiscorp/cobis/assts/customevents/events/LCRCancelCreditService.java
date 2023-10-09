package com.cobiscorp.cobis.assts.customevents.events;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.common.BaseEvent;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.individualloan.dto.CancelCreditRequest;

public class LCRCancelCreditService extends BaseEvent{
	
	private static final ILogger logger = LogFactory
			.getLogger(BlockCreditService.class);
	
	public LCRCancelCreditService(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}
	
	protected ServiceResponse executeCancelService(String loanBankId) {
		
		if (logger.isDebugEnabled()) {
			logger.logDebug("CancelCreditService executeCancelService >>>");
		}
		
		CancelCreditRequest cancelCreditRequest = new CancelCreditRequest();
		cancelCreditRequest.setBankId(loanBankId);

		ServiceRequestTO serviceRequestTO = new ServiceRequestTO();
		ServiceResponse serviceResponse;
		
		serviceRequestTO.addValue("inCancelCreditRequest", cancelCreditRequest);
		
		serviceResponse = this.execute(logger, "IndividualLoan.CancelManagement.CancelLCR", serviceRequestTO);
		
		return serviceResponse;
	}
}
