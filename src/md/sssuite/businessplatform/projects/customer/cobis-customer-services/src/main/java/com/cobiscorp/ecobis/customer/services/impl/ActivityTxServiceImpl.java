package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.ecobis.customer.bl.ActivityManager;
import com.cobiscorp.ecobis.customer.services.ActivityTxService;
import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;


public class ActivityTxServiceImpl implements ActivityTxService{
	
	ActivityManager activityManager;
	
	public ActivityManager getActivityManager() {
		return activityManager;
	}

	public void setActivityManager(ActivityManager activityManager) {
		this.activityManager = activityManager;
	}


	@Override
	public List<EconomicActivityResponse> getEconomicActivity(
			EconomicActivityResponse request) {
		
		List<EconomicActivityResponse> resp = activityManager.getEconomicActivity(request);
				return resp;
	}

	@Override
	public List<MainActivityResponse> getMainActivity(
			MainActivityResponse request) {
		List<MainActivityResponse> resp = activityManager.getMainActivity(request);
		return resp;
	}
	
}
