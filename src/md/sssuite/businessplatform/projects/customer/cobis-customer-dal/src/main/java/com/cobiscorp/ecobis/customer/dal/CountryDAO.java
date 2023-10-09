package com.cobiscorp.ecobis.customer.dal;

import java.util.List;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta
 *
 */
public interface CountryDAO {
	public List<NationalityResponse> getSearchNationality (NationalityResponse request);

}
