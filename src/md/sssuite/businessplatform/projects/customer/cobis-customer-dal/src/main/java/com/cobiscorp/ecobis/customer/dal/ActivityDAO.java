package com.cobiscorp.ecobis.customer.dal;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public interface ActivityDAO {

	public List<EconomicActivityResponse> getEconomicActivity(EconomicActivityResponse request);
	public List<MainActivityResponse> getMainActivity(MainActivityResponse request);
}
