package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.ActivityManager;
import com.cobiscorp.ecobis.customer.dal.ActivityDAO;
import com.cobiscorp.ecobis.customer.services.dtos.EconomicActivityResponse;
import com.cobiscorp.ecobis.customer.services.dtos.MainActivityResponse;

public class ActivityManagerImpl implements ActivityManager {
	private static ILogger logger = LogFactory.getLogger(CustomerManagerImpl.class);

	ActivityDAO activityDao;

	public ActivityDAO getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDAO activityDao) {
		this.activityDao = activityDao;
	}

	@Override
	public List<EconomicActivityResponse> getEconomicActivity(EconomicActivityResponse request) {
		List<EconomicActivityResponse> listEconActResponse = activityDao.getEconomicActivity(request);
			
		
		if(listEconActResponse!=null){
			if(listEconActResponse.size()==0){
				throw new BusinessException(0, "ECONOMIC ACTIVITY NOT FOUND");
			}
			
		}
		else {
			logger.logError("listEconActResponse= " + listEconActResponse);
		}
		return listEconActResponse;
		
	}

	@Override
	public List<MainActivityResponse> getMainActivity(MainActivityResponse request) {

		List<MainActivityResponse> listMainActResponse = activityDao.getMainActivity(request);

		if(listMainActResponse.size()==0){
			throw new BusinessException(0, "MAIN ACTIVITY NOT FOUND");
		}
		
		return listMainActResponse;
	}
	
}
