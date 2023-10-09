package com.cobiscorp.ecobis.mobile.commons.services;

import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.api.customization.arguments.IGridRowCommandEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.RequestName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ReturnName;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.ServiceId;
import com.cobiscorp.ecobis.mobile.commons.services.utils.CallServices;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.CustomerSyncRequest;
import cobiscorp.ecobis.mobilemanagement.dto.DeviceSyncBatchRequest;
import cobiscorp.ecobis.mobilemanagement.dto.DeviceSyncRequest;
import cobiscorp.ecobis.mobilemanagement.dto.GroupSyncRequest;
import cobiscorp.ecobis.mobilemanagement.dto.SyncFilterRequest;
import cobiscorp.ecobis.mobilemanagement.dto.SyncRequest;
import cobiscorp.ecobis.mobilemanagement.dto.SyncResponse;

public class SyncManager  extends BaseEvent {

	public SyncManager(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}
	
	public void syncCustomerByOfficial(CustomerSyncRequest customerSyncRequest, IGridRowCommandEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.CUSTOMERSYNC_REQUEST, customerSyncRequest, ServiceId.CUSTOMER_SYNC, arg1);
	}
	public void syncGroupByOfficial(GroupSyncRequest groupSyncRequest, IGridRowCommandEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.GROUPSYNC_REQUEST, groupSyncRequest, ServiceId.GROUP_SYNC, arg1);
	}
	public void syncDevice(DeviceSyncRequest deviceSyncRequest,IGridRowCommandEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.DEVICESYNC_REQUEST, deviceSyncRequest, ServiceId.DEVICE_SYNC, arg1);		
	}
	public void addBatchSyncDevice(DeviceSyncBatchRequest deviceSyncRequest, IGridRowCommandEventArgs args) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.SYNC_BATCH_REQUEST, deviceSyncRequest, ServiceId.DEVICE_SYNC_BATCH, args);		
	}
	
	public SyncResponse[] searchSyncData(SyncFilterRequest syncDataRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());

		SyncResponse[] sync = callService.callServiceWithReturnArray(RequestName.SYNCDATA_REQUEST, syncDataRequest, ServiceId.SEARCH_SYNCDATA,
				ReturnName.SYNCDATA_RESPONSE, arg1);
		return sync == null ? new SyncResponse[0] : sync;
	}
	
	public void updateSyncs(SyncRequest syncRequest, ICommonEventArgs arg1) throws BusinessException {
		CallServices callService = new CallServices(getServiceIntegration());
		callService.callService(RequestName.SYNC_REQUEST, syncRequest, ServiceId.UPDATE_SYNCDATA, arg1);

	}
	
}
