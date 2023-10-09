package com.cobiscorp.ecobis.customer.prospect.commons.constants;

public interface ServiceId {
	
	// CUSTOMER BUSSINES
	String CREATE_MOBILES    = "MobileManagement.MobileManagement.CreateMobile";
	String UPDATE_MOBILES    = "MobileManagement.MobileManagement.UpdateMobile";
	String DELETE_MOBILES    = "MobileManagement.MobileManagement.DeleteMobile";
	String SEARCH_MOBILES    = "MobileManagement.MobileManagement.SearchMobile";
	String SEARCH_MOBILES_BY_FILTER = "MobileManagement.MobileManagement.SearchMobileByFilter";
	
	// OFFICIAL SYNC
	String GROUP_SYNC        = "MobileManagement.SyncManagement.GroupSyncOfficial";
	String CUSTOMER_SYNC     = "MobileManagement.SyncManagement.CustomerSyncOfficial";
	String DEVICE_SYNC     	 = "MobileManagement.SyncManagement.DeviceSync";
	String DEVICE_SYNC_BATCH = "MobileManagement.SyncManagement.DeviceSyncBatch";
	
	// SYNC DATA
	String SEARCH_SYNCDATA   = "MobileManagement.SyncManagement.SearchSyncData";
	String UPDATE_SYNCDATA   = "MobileManagement.SyncManagement.UpdateSyncData";
	
	
}
