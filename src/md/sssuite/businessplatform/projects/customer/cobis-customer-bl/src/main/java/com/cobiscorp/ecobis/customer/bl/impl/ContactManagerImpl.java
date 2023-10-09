package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.ContactManager;
import com.cobiscorp.ecobis.customer.dal.ContactDAO;
import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public class ContactManagerImpl implements ContactManager {
	private static ILogger logger = LogFactory.getLogger(ContactManagerImpl.class);

	ContactDAO contactDAO;

	public ContactDAO getContactDAO() {
		return contactDAO;
	}

	public void setContactDAO(ContactDAO contactDAO) {
		this.contactDAO = contactDAO;
	}

	public List<ContactDataResponse> getContactsbyCustomer(CustomerDataRequest request) {
		List<ContactDataResponse> listContactDataResponse = contactDAO.getContactsbyCustomer(request);
		if (listContactDataResponse != null && listContactDataResponse.size() == 0) {
			if (logger.isDebugEnabled()) {
				logger.logDebug("CONTACT BY ENTITY IS EMPTY");
			}

			return null;
		} else {
			logger.logError("listContactDataResponse" + listContactDataResponse);
		}
		return listContactDataResponse;
	}

}
