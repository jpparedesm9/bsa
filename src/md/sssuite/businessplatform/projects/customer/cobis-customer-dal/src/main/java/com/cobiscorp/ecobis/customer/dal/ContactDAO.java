package com.cobiscorp.ecobis.customer.dal;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public interface ContactDAO {

	public List<ContactDataResponse> getContactsbyCustomer(CustomerDataRequest request);
}
