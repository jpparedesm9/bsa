package com.cobiscorp.ecobis.customer.commons.prospect.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.CustomerSyncRequest;
import cobiscorp.ecobis.mobilemanagement.dto.GroupSyncRequest;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.services.utils.CallServices;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;

public class SyncManager  extends BaseEvent {

	public SyncManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public void syncCustomer(CustomerSyncRequest customerSyncRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.CUSTOMER_SYNC_REQUEST, customerSyncRequest, ServiceId.CUSTOMER_SYNC, arg1);
	}
	
}
