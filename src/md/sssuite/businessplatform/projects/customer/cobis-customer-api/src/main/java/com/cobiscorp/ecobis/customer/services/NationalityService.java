package com.cobiscorp.ecobis.customer.services;

import java.util.List;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta
 * interface for search nationality
 */
public interface NationalityService {

	public List<NationalityResponse> searchNationality(NationalityResponse request);
	
}
