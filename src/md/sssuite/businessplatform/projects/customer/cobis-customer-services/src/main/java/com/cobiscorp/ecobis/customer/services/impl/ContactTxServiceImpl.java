package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.ContactTxService;
import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.bl.ContactManager;

public class ContactTxServiceImpl implements ContactTxService {

	private ContactManager contactManager;

	public List<ContactDataResponse> getContactsbyCustomer(
			CustomerDataRequest customer) {
		return contactManager.getContactsbyCustomer(customer);
	}

	public ContactManager getContactManager() {
		return contactManager;
	}

	public void setContactManager(ContactManager contactManager) {
		this.contactManager = contactManager;
	}	

}
