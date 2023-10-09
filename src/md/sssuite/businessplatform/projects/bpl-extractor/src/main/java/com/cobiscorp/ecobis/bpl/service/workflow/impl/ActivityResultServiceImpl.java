package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.List;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityResultDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityResultService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;

public class ActivityResultServiceImpl implements ActivityResultService {

	private ActivityResultDao activityResultDao;

	/**
	 * @return the activityResultDao
	 */
	public ActivityResultDao getActivityResultDao() {
		return activityResultDao;
	}

	/**
	 * @param activityResultDao
	 *            the activityResultDao to set
	 */
	public void setActivityResultDao(ActivityResultDao activityResultDao) {
		this.activityResultDao = activityResultDao;
	}

	public List<ActivityResult> findActivityResultByIdStep(Integer idStep) {
		return activityResultDao.findActivityResultByIdStep(idStep);
	}

	public ActivityResult save(ActivityResult activityResult) throws Exception {
		return activityResultDao.saveActivityResult(activityResult);
	}

}
