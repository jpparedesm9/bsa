package com.cobiscorp.ecobis.customer.services;



import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;


public interface QuickCreateTxService {

	public CustomerDataResponse executeQuickCreate( CustomerQuickCreateRequest request );
	
}
