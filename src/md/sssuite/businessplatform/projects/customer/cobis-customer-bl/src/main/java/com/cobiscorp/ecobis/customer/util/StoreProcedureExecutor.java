package com.cobiscorp.ecobis.customer.util;

import java.util.List;
 


import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public interface StoreProcedureExecutor {
	
	public List<AddressDataResponse>  executorAddressSearch(Integer customer);
	
	public CustomerDataResponse executorQuickCreate(CustomerQuickCreateRequest request);
	
}


