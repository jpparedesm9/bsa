package com.cobiscorp.ecobis.customer.services;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface AddressTxService {

	public List<AddressDataResponse> getAddressesbyCustomer(CustomerDataRequest customer);
	
}
