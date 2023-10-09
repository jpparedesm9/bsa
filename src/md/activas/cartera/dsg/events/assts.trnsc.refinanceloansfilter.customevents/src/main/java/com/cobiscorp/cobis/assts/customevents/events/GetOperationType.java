package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.OperationTypeResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IChangedEvent;
import com.cobiscorp.designer.api.customization.arguments.IChangedEventArgs;
import com.cobiscorp.designer.common.BaseEvent;

public class GetOperationType extends BaseEvent implements IChangedEvent {

	private static final ILogger logger = LogFactory.getLogger(GetOperationType.class);
	
	public GetOperationType(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void changed(DynamicRequest entities, IChangedEventArgs args) {
		ServiceResponse serviceResponse;
		ServiceRequestTO request = new ServiceRequestTO();
		
		DataEntity refinancingLoanFilter = entities.getEntity(RefinanceLoanFilter.ENTITY_NAME);
		
		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setOperation('Q');
		loanRequest.setCreditLine(refinancingLoanFilter.get(RefinanceLoanFilter.OPERATIONTYPE));
		loanRequest.setCurrency(refinancingLoanFilter.get(RefinanceLoanFilter.CURRENCYTYPE));
		
		request.addValue("inLoanRequest", loanRequest);
		serviceResponse = this.execute(logger, Parameter.READ_OPERATIONTYPE, request);
		
		if (serviceResponse != null && serviceResponse.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) serviceResponse.getData();
			OperationTypeResponse[] operationTypeList = (OperationTypeResponse[]) result.getValue("returnOperationTypeResponse"); 
			
			for (OperationTypeResponse o : operationTypeList) {
				refinancingLoanFilter.set(RefinanceLoanFilter.NEWLOANTERM, o.getTerm());
				refinancingLoanFilter.set(RefinanceLoanFilter.PERIODICITY, o.getTermType());
			}
		}
	}

}
