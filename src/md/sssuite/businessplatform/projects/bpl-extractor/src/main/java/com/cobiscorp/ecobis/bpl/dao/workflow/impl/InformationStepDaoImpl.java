package com.cobiscorp.ecobis.bpl.dao.workflow.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import com.cobiscorp.ecobis.bpl.dao.workflow.InformationStepDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.LinkConditionDao;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.InformationStep;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.LinkCondition;

public class InformationStepDaoImpl implements InformationStepDao {

	@PersistenceContext
	private EntityManager entityManager;

	public EntityManager getEntityManager() {
		return entityManager;
	}

	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@SuppressWarnings("unchecked")
	public List<InformationStep> findByLink(Integer idStep) {

		StringBuilder sql = new StringBuilder();
		sql.append(" SELECT ip  FROM InformationStep ip ");
		sql.append(" WHERE ip.step.idStep = :idStep ");

		Query query = entityManager.createQuery(sql.toString());
		query.setParameter("idStep", idStep);

		return query.getResultList();

	}

}
