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
import com.cobiscorp.ecobis.customer.dal.PhoneDAO;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;

public class PhoneDAOImpl extends BaseDAOImpl implements PhoneDAO {
	private static ILogger logger = LogFactory.getLogger(PhoneDAOImpl.class);

	public PhoneDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<PhoneDataResponse> getPhonebyCustomer(CustomerDataRequest request) {
		logger.logDebug("Start getPhonebyCustomerAndAddress");

		try {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("Idcustomer", request.getCustomerId());
		List<PhoneDataResponse> phoneDataResponse = this.getResultList("Phone.getPhoneCustomer", parametersList, PhoneDataResponse.class);
		return phoneDataResponse;
		} catch (NoResultException nrex) {
			return new ArrayList<PhoneDataResponse>();
		} catch (Exception ex) {
			logger.logError("Error in getPhonebyCustomer:", ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug("Finish getPhonebyCustomer");
		}

	}

	@Override
	public List<PhoneDataResponse> getPhonebyCustomerAndAddress(PhoneDataRequest request) {
		logger.logDebug("Start getPhonebyCustomerAndAddress");

		try {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("IdCustomer", request.getCustomerID());
		parametersList.put("IdAddress", request.getAddressId());
		List<PhoneDataResponse> phoneDataResponse = this.getResultList("Phone.getPhoneCustomerAddress", parametersList, PhoneDataResponse.class);
		return phoneDataResponse;
		} catch (NoResultException nrex) {
			return new ArrayList<PhoneDataResponse>();
		} catch (Exception ex) {
			logger.logError("Error in getPhonebyCustomerAndAddress:", ex);
			throw new BusinessException(7300026, "Operation failure. Contact Administrator.");
		} finally {
			logger.logDebug("Finish getPhonebyCustomerAndAddress");
		}

	}

}