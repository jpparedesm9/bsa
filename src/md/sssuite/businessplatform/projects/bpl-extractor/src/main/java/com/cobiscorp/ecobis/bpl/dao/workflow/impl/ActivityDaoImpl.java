package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityDao;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;

public class ActivityDaoImpl implements ActivityDao {
	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	public Activity saveActivity(Activity activity) throws Exception {
		entityManager.persist(activity);
		// entityManager.flush();
		return activity;
	}

	@SuppressWarnings("unchecked")
	public Activity findByName(String name) throws Exception {

		Query query = entityManager.createNamedQuery("Activity.findByName");
		query.setParameter("name", name);
		List<Activity> activityList = (List<Activity>) query.getResultList();

		if (activityList.isEmpty()) {
			return null;
		} else {
			return activityList.get(0);
		}
	}

	public Activity findAndSaveActivity(Activity activity, DriverManagerDataSource dataSource) throws Exception {
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);

		Activity searchActivity = hmActivity.get(activity.getName());
		if (searchActivity == null) {
			searchActivity = findByName(activity.getName());
			if (searchActivity == null) {
				activity.setIdActivity(seqnos.execute("wf_actividad"));
				activity = saveActivity(activity);
				hmActivity.put(activity.getName(), activity);
				return activity;
			}
			hmActivity.put(searchActivity.getName(), searchActivity);

		}
		return searchActivity;
	}

}
