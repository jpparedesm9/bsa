/**
 * 
 */
package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.NationalityManager;
import com.cobiscorp.ecobis.customer.services.NationalityService;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta
 * Nationality Service Implement
 */
public class NationalityServiceImpl implements NationalityService{
	@SuppressWarnings("unused")
	private static ILogger logger = LogFactory.getLogger(NationalityServiceImpl.class);
	
	private NationalityManager nationalityManager;  

	@Override
	public List<NationalityResponse> searchNationality(NationalityResponse request) {
		
		List<NationalityResponse> nationalityResponses = nationalityManager.getNationality(request);
		return nationalityResponses;
	}

	public void setNationalityManager(NationalityManager nationalityManager) {
		this.nationalityManager = nationalityManager;
	}
	public void unsetNationalityManager(NationalityManager nationalityManager) {
		this.nationalityManager = null;
	}

}
