package com.cobiscorp.ecobis.customer.bl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface ContactManager {
	public List<ContactDataResponse> getContactsbyCustomer(CustomerDataRequest request);	
}
