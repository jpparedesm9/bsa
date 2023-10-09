package com.cobiscorp.ecobis.customer.services;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public interface ActivityTxService {

	/**
	* Method to consult the Economic Activities.
	* @author
	**/
	
	public List<EconomicActivityResponse> getEconomicActivity(EconomicActivityResponse request);
	
	
	/**
	* Method to consult the Main Activities 
	* @author 
	**/	
	
	public  List<MainActivityResponse> getMainActivity(MainActivityResponse request);
	
}
