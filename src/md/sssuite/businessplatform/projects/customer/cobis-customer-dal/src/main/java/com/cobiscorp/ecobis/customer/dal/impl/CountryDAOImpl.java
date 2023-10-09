/**
 * 
 */
package com.cobiscorp.ecobis.customer.dal.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.dal.CountryDAO;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta Implement of CountryDAO
 */
public class CountryDAOImpl extends BaseDAOImpl implements CountryDAO {

	private static ILogger logger = LogFactory.getLogger(CountryDAOImpl.class);

	public CountryDAOImpl() {
		super();
	}

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public List<NationalityResponse> getSearchNationality(
			NationalityResponse request) {
		Map<String, Object> parametersList = new HashMap<String, Object>();
		List<NationalityResponse> nationalityResponse;
		if (request.getCountryId() != null) {
			parametersList.put("countryId", request.getCountryId());
			nationalityResponse = this.getResultList(
					"Country.getNationalityByCode", parametersList,
					NationalityResponse.class);
		} else {
			nationalityResponse = this.getResultList(
					"Country.getNationalityAll", parametersList,
					NationalityResponse.class);
		}
		return nationalityResponse;
	}

}
