package com.cobiscorp.ecobis.customer.bl;

import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;


public interface CreationCustomerManager {
	public CustomerDataRequest normalCreationCustomer(CustomerDataResponse request);
}
