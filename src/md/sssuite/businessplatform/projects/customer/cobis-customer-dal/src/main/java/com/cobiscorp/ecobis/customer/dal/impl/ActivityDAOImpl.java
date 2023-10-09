package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.dal.ActivityDAO;
import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public class ActivityDAOImpl extends BaseDAOImpl implements ActivityDAO {
	private static ILogger logger = LogFactory.getLogger(ActivityDAOImpl.class);

	public ActivityDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<MainActivityResponse> getMainActivity(
			MainActivityResponse request) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("Idbusiness", request.getBusiness());
		List<MainActivityResponse> mainActivityResponse = this.getResultList(
				"MainActivity.getMainActivity", parametersList,
				MainActivityResponse.class);
		return mainActivityResponse;

	}

	@Override
	public List<EconomicActivityResponse> getEconomicActivity(
			EconomicActivityResponse request) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		parametersList.put("idIndustry", request.getIndustry());
		List<EconomicActivityResponse> economicActivityResponse = this
				.getResultList("EconomicActivity.getEconomicActivity",
						parametersList, EconomicActivityResponse.class);
		return economicActivityResponse;
	}

}
