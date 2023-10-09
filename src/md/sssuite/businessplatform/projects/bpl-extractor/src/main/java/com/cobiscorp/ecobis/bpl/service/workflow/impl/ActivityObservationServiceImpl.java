package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityObservationDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityObservationService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;

public class ActivityObservationServiceImpl implements ActivityObservationService {

	private ActivityObservationDao activityObservationDao;

	/**
	 * @return the activityObservationDao
	 */
	public ActivityObservationDao getActivityObservationDao() {
		return activityObservationDao;
	}

	/**
	 * @param activityObservationDao
	 *            the activityObservationDao to set
	 */
	public void setActivityObservationDao(ActivityObservationDao activityObservationDao) {
		this.activityObservationDao = activityObservationDao;
	}

	public List<ActivityObservation> findActivityObservationByStep(Integer idStep) {
		return activityObservationDao.findActivityObservationByStep(idStep);
	}

	public ActivityObservation save(ActivityObservation activityObservation) throws Exception {
		return activityObservationDao.saveActivityObservation(activityObservation);
	}

}
