package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityObservationDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityObservation;

public class ActivityObservationDaoImpl implements ActivityObservationDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ActivityObservationDao#findActivityObservationByStep(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public List<ActivityObservation> findActivityObservationByStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ab  FROM ActivityObservation ab ");
		sql.append(" WHERE  ab.step.idStep = :idStep ");
		sql.append(" AND    ab.catalog.table.table = 'wf_observacion' ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

	public ActivityObservation saveActivityObservation(ActivityObservation activityObservation) throws Exception {
		entityManager.persist(activityObservation);
		return activityObservation;
	}

}
