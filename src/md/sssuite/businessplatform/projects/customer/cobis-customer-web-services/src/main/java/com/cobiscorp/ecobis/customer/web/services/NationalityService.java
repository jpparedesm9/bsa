package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

/**
 * @author jmoreta
 * 
 */
public interface NationalityService {

	public ServiceResponse searchNationality(NationalityResponse request) throws ParseException;
}
