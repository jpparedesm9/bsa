package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityResultDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityResult;

public class ActivityResultDaoImpl implements ActivityResultDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ActivityResultDao#findActivityResultByIdStep(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public List<ActivityResult> findActivityResultByIdStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ar  FROM ActivityResult ar ");
		sql.append(" WHERE  ar.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

	public ActivityResult saveActivityResult(ActivityResult activityResult) throws Exception {
		entityManager.persist(activityResult);
		return activityResult;
	}

}
