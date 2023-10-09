package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.dal.ContactDAO;
import com.cobiscorp.ecobis.customer.services.dtos.ContactDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;

public class ContactDAOImpl extends BaseDAOImpl implements ContactDAO {
	private static ILogger logger = LogFactory.getLogger(ContactDAOImpl.class);

	public ContactDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<ContactDataResponse> getContactsbyCustomer(
			CustomerDataRequest request) {
		
		try {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("Idcustomer", request.getCustomerId());
		List<ContactDataResponse> contactDataResponse = this.getResultList(
				"Contact.getContactsbyCustomer", parametersList,
				ContactDataResponse.class);
		return contactDataResponse;
		} catch (NoResultException nrex) {
			return new ArrayList<ContactDataResponse>();
		} catch (Exception ex) {
			logger.logError("Error in getContactsbyCustomer:", ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug("Finish getPhonebyCustomerAndAddress");
		}
	}

}
