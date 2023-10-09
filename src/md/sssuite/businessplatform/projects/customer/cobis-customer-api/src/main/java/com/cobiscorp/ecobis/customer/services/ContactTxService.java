package com.cobiscorp.ecobis.customer.services;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface ContactTxService {

	public List<ContactDataResponse> getContactsbyCustomer(CustomerDataRequest customer);
	
}
