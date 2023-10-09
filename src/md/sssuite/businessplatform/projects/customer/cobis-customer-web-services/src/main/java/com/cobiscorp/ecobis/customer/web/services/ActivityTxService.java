package com.cobiscorp.ecobis.customer.web.services;

import java.text.ParseException;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public interface ActivityTxService {

	public ServiceResponse getEconomicActivity(EconomicActivityResponse request) throws ParseException;;

	public ServiceResponse getMainActivity(MainActivityResponse request) throws ParseException;;
}
