package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.dal.BusinessSegmentDAO;
import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;

public class BusinessSegmentDAOImpl extends BaseDAOImpl implements
		BusinessSegmentDAO {

	private static ILogger logger = LogFactory
			.getLogger(BusinessSegmentDAOImpl.class);

	public BusinessSegmentDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<BusinessSegmentResponse> getBusinessSegment(
			BusinessSegmentResponse line) {

		// TODO Auto-generated method stub
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("Idline", line.getLine());
		List<BusinessSegmentResponse> businessSegmentResponse = this
				.getResultList("BusinessSegment.getBusinessSegment",
						parametersList, BusinessSegmentResponse.class);
		return businessSegmentResponse;

	}

}
