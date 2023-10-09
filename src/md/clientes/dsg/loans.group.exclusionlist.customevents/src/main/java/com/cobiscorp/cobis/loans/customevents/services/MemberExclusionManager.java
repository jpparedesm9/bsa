package com.cobiscorp.cobis.loans.customevents.services;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.loans.customevents.constants.RequestName;
import com.cobiscorp.cobis.loans.customevents.constants.ReturnName;
import com.cobiscorp.cobis.loans.customevents.constants.ServiceId;
import com.cobiscorp.cobis.loans.model.ExclusionListResult;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.CallServices;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerExclusionListResponse;


public class MemberExclusionManager extends BaseEvent {

	private static final ILogger LOGGER = LogFactory.getLogger(MemberExclusionManager.class);

	public MemberExclusionManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	public CustomerExclusionListResponse[] searchMemberExclution(CustomerExclusionListRequest customerExclusionListRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		CustomerExclusionListResponse[] searchMemberEx = callService.callServiceWithReturnArray(RequestName.EXCLUTION_MEMBER, customerExclusionListRequest, ServiceId.SEARCH_EXCLUTION_LIST,ReturnName.RETURNEXCLUTIONRESPONSE, arg1);
		return searchMemberEx == null ? new CustomerExclusionListResponse[0] : searchMemberEx;
	}

	public void createCustomerExclusion(CustomerExclusionListRequest CustomerExclusionRequest, ICommonEventArgs arg1) {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.EXCLUTION_MEMBER, CustomerExclusionRequest, ServiceId.CREATE_EXCLUTION_LIST , arg1);
		
	}
	
	public void deleteCustomerExclusion(CustomerExclusionListRequest CustomerExclusionRequest, ICommonEventArgs arg1) {
		LOGGER.logDebug("call services Delete : " + getServiceIntegration());    
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.EXCLUTION_MEMBER, CustomerExclusionRequest, ServiceId.DELETE_EXCLUTION_LIST , arg1);
		
	}
	
}
