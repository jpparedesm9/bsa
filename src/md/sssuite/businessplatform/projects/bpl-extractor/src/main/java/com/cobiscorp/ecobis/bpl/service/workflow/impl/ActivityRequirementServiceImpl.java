package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityRequirementDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityRequirementService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;

public class ActivityRequirementServiceImpl implements ActivityRequirementService {

	private ActivityRequirementDao activityRequirementDao;

	/**
	 * @return the activityRequirementDao
	 */
	public ActivityRequirementDao getActivityRequirementDao() {
		return activityRequirementDao;
	}

	/**
	 * @param activityRequirementDao
	 *            the activityRequirementDao to set
	 */
	public void setActivityRequirementDao(ActivityRequirementDao activityRequirementDao) {
		this.activityRequirementDao = activityRequirementDao;
	}

	public List<ActivityRequirement> findActivityRequirementByStep(Integer idStep) {
		return activityRequirementDao.findActivityRequirementByStep(idStep);
	}

	public ActivityRequirement save(ActivityRequirement activityRequirement) throws Exception {
		return activityRequirementDao.saveActivityRequirement(activityRequirement);
	}

}
