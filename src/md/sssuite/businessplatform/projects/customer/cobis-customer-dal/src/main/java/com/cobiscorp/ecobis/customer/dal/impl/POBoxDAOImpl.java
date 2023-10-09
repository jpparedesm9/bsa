package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.dal.POBoxDAO;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;

public class POBoxDAOImpl extends BaseDAOImpl implements POBoxDAO {

	private static ILogger logger = LogFactory.getLogger(POBoxDAOImpl.class);

	public POBoxDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<POBoxDataResponse> getAllPOBox(CustomerDataRequest request) {
		List<POBoxDataResponse> listPOBoxResponse = new ArrayList<POBoxDataResponse>();
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("idCustomer", request.getCustomerId());
		logger.logDebug("DAL POBOX");
		listPOBoxResponse = this.getResultList("POBox.getAllData",
				parametersList, POBoxDataResponse.class);
		logger.logDebug("# List POBOX: " + listPOBoxResponse.size());
		return listPOBoxResponse;
	}

}