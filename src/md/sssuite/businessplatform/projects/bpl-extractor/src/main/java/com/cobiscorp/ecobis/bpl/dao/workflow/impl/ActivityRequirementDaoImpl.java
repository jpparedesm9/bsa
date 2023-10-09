package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityRequirementDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ActivityRequirement;

public class ActivityRequirementDaoImpl implements ActivityRequirementDao {

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
	 * @see com.cobiscorp.ecobis.bpl.dao.workflow.ActivityRequirementDao#findActivityRequirementByProcessVersion(java.lang.Integer)
	 */
	@SuppressWarnings("unchecked")
	public List<ActivityRequirement> findActivityRequirementByStep(Integer idStep) {
		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ar  FROM ActivityRequirement ar ");
		sql.append(" WHERE  ar.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();
	}

	public ActivityRequirement saveActivityRequirement(ActivityRequirement activityRequirement) throws Exception {
		entityManager.persist(activityRequirement);
		return activityRequirement;
	}

}
