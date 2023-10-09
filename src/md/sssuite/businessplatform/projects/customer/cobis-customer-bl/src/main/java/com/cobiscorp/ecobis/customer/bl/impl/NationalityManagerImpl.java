/**
 * 
 */
package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.NationalityManager;
import com.cobiscorp.ecobis.customer.dal.CountryDAO;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta Implementation of NationalityManager
 */
public class NationalityManagerImpl implements NationalityManager {

	private static ILogger logger = LogFactory
			.getLogger(NationalityManagerImpl.class);
	CountryDAO countryDAO;

	public static ILogger getLogger() {
		return logger;
	}

	public static void setLogger(ILogger logger) {
		NationalityManagerImpl.logger = logger;
	}

	public CountryDAO getCountryDAO() {
		return countryDAO;
	}

	public void setCountryDAO(CountryDAO countryDAO) {
		this.countryDAO = countryDAO;
	}

	@Override
	public List<NationalityResponse> getNationality(NationalityResponse request) {
		List<NationalityResponse> listNationalityResponse = new ArrayList<NationalityResponse>();
		List<NationalityResponse> listAllNationality = countryDAO
				.getSearchNationality(request);
		if (listAllNationality != null) {
			for (NationalityResponse nationalityResponse : listAllNationality) {
				NationalityResponse natResponse = new NationalityResponse();

				natResponse.setCountryId(nationalityResponse.getCountryId());
				natResponse
						.setDescription(nationalityResponse.getDescription());
				natResponse.setAbbreviation(nationalityResponse
						.getAbbreviation());
				natResponse
						.setNationality(nationalityResponse.getNationality());
				natResponse.setContinent(nationalityResponse.getContinent());
				natResponse.setStatus(nationalityResponse.getStatus());

				listNationalityResponse.add(natResponse);
			}
			return null;
		}else{
			logger.logError("listAllNationality= " + listAllNationality);
		}
		return listNationalityResponse;
	}

}
