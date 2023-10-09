package com.cobiscorp.ecobis.customer.services;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;

public interface CustomerTxService {

	public CustomerDataResponse getCustomerDetails(CustomerDataRequest request);
	public CustomerDataResponse getCustomerAllData(CustomerDataRequest request);
	public IdSearchResponse searchById(IdSearchRequest idSearchRequest);
	public CustomerDataRequest createCustomer(CustomerDataResponse request);
	public CustomerDataResponse getCustomerNameById(CustomerDataRequest request);	
}
