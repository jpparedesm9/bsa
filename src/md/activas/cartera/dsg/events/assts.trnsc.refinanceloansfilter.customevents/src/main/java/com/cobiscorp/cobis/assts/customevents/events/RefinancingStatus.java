package com.cobiscorp.cobis.assts.customevents.events;

import cobiscorp.ecobis.assets.cloud.dto.LoanRequest;
import cobiscorp.ecobis.assets.cloud.dto.RefinancingStatusResponse;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

import com.cobiscorp.cobis.assets.commons.parameters.Parameter;
import com.cobiscorp.cobis.assts.model.RefinanceLoanFilter;
import com.cobiscorp.cobis.assts.model.RefinanceLoans;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.common.BaseEvent;

public class RefinancingStatus extends BaseEvent {

	public RefinancingStatus(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	private static final ILogger logger = LogFactory.getLogger(RefinancingStatus.class);

	public void setRefinancingStatus(DynamicRequest entities) {

		ServiceRequestTO request = new ServiceRequestTO();
		ServiceResponse response;

		DataEntity refinancingLoanFilter = entities.getEntity(RefinanceLoanFilter.ENTITY_NAME);
		DataEntityList operationList = entities.getEntityList(RefinanceLoans.ENTITY_NAME);

		if (operationList.isEmpty()) {
			refinancingLoanFilter.set(RefinanceLoanFilter.OVERDUE, "NO");
			return;
		}
		
		String operationsListStr = "";
		for (DataEntity o : operationList) {
			operationsListStr = operationsListStr + o.get(RefinanceLoans.LOAN).trim() + ",";
		}

		LoanRequest loanRequest = new LoanRequest();
		loanRequest.setBank(operationsListStr);
		loanRequest.setOperation('R');
		loanRequest.setTypeOperation("R");

		request.addValue("inLoanRequest", loanRequest);
		response = this.execute(logger, Parameter.GET_REFINANCING_STATUS, request);
		
		if (response.isResult()) {
			ServiceResponseTO result = (ServiceResponseTO) response.getData();
			RefinancingStatusResponse[] clResponse = (RefinancingStatusResponse[]) result.getValue("returnRefinancingStatusResponse");

			for (RefinancingStatusResponse r : clResponse) {
				refinancingLoanFilter.set(RefinanceLoanFilter.OVERDUE, r.getBornOverdue());
			}
		}
	}

}
