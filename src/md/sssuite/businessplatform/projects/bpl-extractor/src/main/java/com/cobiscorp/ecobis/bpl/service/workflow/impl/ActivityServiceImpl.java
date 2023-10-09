package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ActivityService;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;

public class ActivityServiceImpl implements ActivityService {

	private ActivityDao activityDao;
	
	static Logger log = Logger.getLogger(AddresseeServiceImpl.class);

	public ActivityDao getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	public Activity findByName(String name) throws Exception {
		return activityDao.findByName(name);
	}

	public Activity saveActivity(Activity activity) throws Exception {
		return activityDao.saveActivity(activity);
	}

	public Activity findAndSave(Activity activity, DriverManagerDataSource dataSource) throws Exception {

		log.debug("Activity------------------------------------------>1");
		// Declaro la clase para ejecutar el seqnos
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		log.debug("Activity------------------------------------------>2");
		Activity searchActivity = hmActivity.get(activity.getName());
		
		log.debug("Activity------------------------------------------>3");
		
		if (searchActivity == null) {
			
			log.debug("Activity------------------------------------------>4");
			searchActivity = findByName(activity.getName());
			log.debug("Activity------------------------------------------>5");
			if (searchActivity == null) {
				log.debug("Activity------------------------------------------>6");
				activity.setIdActivity(seqnos.execute("wf_actividad"));
				log.debug("Activity------------------------------------------>7");
				searchActivity = activityDao.saveActivity(activity);
				log.debug("Activity------------------------------------------>8");
			}
			log.debug("Activity------------------------------------------>9");
			hmActivity.put(activity.getName(), searchActivity);
			log.debug("Activity------------------------------------------>10");
		}
		return searchActivity;
	}

}
